CLASS lhc_zi_travel_kashi_m DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_kashi_m RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_travel_kashi_m RESULT result.
    METHODS accepttravel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_kashi_m~accepttravel RESULT result.

    METHODS copytravel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_kashi_m~copytravel.

    METHODS recalctoprice FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_kashi_m~recalctoprice.

    METHODS rejecttravel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_kashi_m~rejecttravel RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travel_kashi_m.

ENDCLASS.

CLASS lhc_zi_travel_kashi_m IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA(lt_entities) = entities.
    DELETE lt_entities WHERE travelid IS NOT INITIAL.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = '01'
            object            = '/DMO/TRV_M'
            quantity          = CONV #( lines( lt_entities )  )
         IMPORTING
            number            = DATA(lv_latest_num)
            returncode        = DATA(lv_code)
            returned_quantity = DATA(lv_qty)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).
        LOOP AT lt_entities INTO DATA(ls_entities).
          APPEND VALUE #( %cid = ls_entities-%cid
                           %key = ls_entities-%key  )
                       TO failed-zi_travel_kashi_m.
          APPEND VALUE #( %cid = ls_entities-%cid
                         %key = ls_entities-%key
                         %msg = lo_error )
                     TO reported-zi_travel_kashi_m.

        ENDLOOP.

        EXIT.

    ENDTRY.
    ASSERT lv_qty = lines(  lt_entities ).
    DATA: lt_travel_kashi_m TYPE TABLE FOR MAPPED EARLY zi_travel_kashi_m,
          ls_travel_kashi_m LIKE LINE OF  lt_travel_kashi_m.
    DATA(lv_curr_num) = lv_latest_num - lv_qty.

    CLEAR : ls_entities.
    LOOP AT lt_entities INTO ls_entities.

      lv_curr_num = lv_curr_num + 1.
      ls_travel_kashi_m = VALUE #( %cid = ls_entities-%cid
                                    Travelid = lv_curr_num
                                     ).

      APPEND ls_travel_kashi_m TO mapped-zi_travel_kashi_m.

    ENDLOOP.

  ENDMETHOD.

  METHOD accepttravel.

    MODIFY ENTITIES OF zi_travel_kashi_m IN LOCAL MODE
    ENTITY zi_travel_kashi_m
    UPDATE FIELDS ( OverallStatus )
    WITH VALUE #( FOR ls_keys IN keys (  %tky = ls_keys-%tky
                                         OverallStatus = 'A'   ) )
    REPORTED DATA(lt_travel).

    READ ENTITIES OF zi_travel_kashi_m IN LOCAL MODE
    ENTITY zi_travel_kashi_m
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result ( %tky = ls_result-%tky
                                               %param = ls_result ) ).

  ENDMETHOD.

  METHOD copytravel.

    DATA: it_travel   TYPE TABLE FOR CREATE zi_travel_kashi_m,
          it_booking  TYPE TABLE FOR CREATE zi_travel_kashi_m\_booking,
          it_booksupp TYPE TABLE FOR CREATE zi_booking_kashi_m\_booksuppl.

    READ TABLE keys ASSIGNING FIELD-SYMBOL(<ls_withoutcid>) WITH KEY %cid = ' '.
    ASSERT <ls_withoutcid> IS NOT ASSIGNED.
    READ ENTITIES OF  zi_travel_kashi_m IN LOCAL MODE
    ENTITY  zi_travel_kashi_m
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel_r)
    FAILED DATA(lt_failed).

    READ ENTITIES OF  zi_travel_kashi_m IN LOCAL MODE
   ENTITY  zi_travel_kashi_m BY \_booking
    ALL FIELDS WITH CORRESPONDING #( lt_travel_r )
    RESULT DATA(lt_booking_r).
    " failed data(lt_failed).

    READ ENTITIES OF  zi_travel_kashi_m IN LOCAL MODE
       ENTITY  zi_booking_kashi_m BY \_booksuppl
       ALL FIELDS WITH CORRESPONDING #( lt_booking_r )
       RESULT DATA(lt_booksupp_r).

    LOOP AT lt_travel_r ASSIGNING FIELD-SYMBOL(<ls_travel_r>).

      APPEND VALUE #(  %cid = keys[ KEY entity Travelid = <ls_travel_r>-travelid ]-%cid
                       %data = CORRESPONDING #( <ls_travel_r> EXCEPT travelid ) )
                       TO it_travel ASSIGNING FIELD-SYMBOL(<ls_travel>).
      <ls_travel>-BeginDate = cl_abap_context_info=>get_system_date( ).
      <ls_travel>-EndDate =  cl_abap_context_info=>get_system_date( ) + 30.
      <ls_travel>-OverallStatus = 'O'.

      APPEND VALUE #( %cid_ref = <ls_travel>-%cid )
      TO it_booking ASSIGNING FIELD-SYMBOL(<it_bookings>).

      LOOP AT lt_booking_r ASSIGNING FIELD-SYMBOL(<ls_booking_r>)
                                  USING KEY entity
                                  WHERE TravelId = <ls_travel_r>-TravelId.

        APPEND VALUE #( %cid = <ls_travel>-%cid && <ls_booking_r>-BookingId
                        %data = CORRESPONDING #( <ls_booking_r> EXCEPT travelid ) )
                        TO <it_bookings>-%target ASSIGNING FIELD-SYMBOL(<ls_booking_n>).

        <ls_booking_n>-BookingStatus = 'N'.

        APPEND VALUE #( %cid_ref = <ls_booking_n>-%cid )
      TO it_booksupp ASSIGNING FIELD-SYMBOL(<ls_booksupp>).

        LOOP AT lt_booksupp_r ASSIGNING FIELD-SYMBOL(<ls_booksupp_r>)
                                                USING KEY entity
                                                WHERE travelid = <ls_travel_r>-TravelId
                                                AND bookingid = <ls_booking_r>-BookingId.

          APPEND VALUE #( %cid = <ls_travel>-%cid && <ls_booking_r>-BookingId && <ls_booksupp_r>-SupplementId
                          %data = CORRESPONDING #( <ls_booksupp_r>  EXCEPT travelid bookingid  )  )
                          TO <ls_booksupp>-%target.

        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

    MODIFY ENTITIES OF zi_travel_kashi_m IN LOCAL MODE
    ENTITY zi_travel_kashi_m
    CREATE FIELDS ( AgencyId CustomerId BeginDate EndDate BookingFee TotalPrice CurrencyCode OverallStatus Description )
    WITH it_travel

    ENTITY zi_travel_kashi_m
    CREATE BY \_booking
    FIELDS ( BookingId BookingDate  CustomerId CarrierId ConnectionId FlightDate FlightPrice CurrencyCode BookingStatus )
    WITH it_booking

    ENTITY zi_booking_kashi_m
    CREATE BY \_booksuppl
    FIELDS ( BookingSupplementId SupplementId Price CurrencyCode )
    WITH it_booksupp

    MAPPED DATA(it_mapped).

    mapped-zi_travel_kashi_m = it_mapped-zi_travel_kashi_m.

  ENDMETHOD.

  METHOD recalctoprice.
  ENDMETHOD.

  METHOD rejecttravel.

    MODIFY ENTITIES OF zi_travel_kashi_m IN LOCAL MODE
      ENTITY zi_travel_kashi_m
      UPDATE FIELDS ( OverallStatus )
      WITH VALUE #( FOR ls_keys IN keys (  %tky = ls_keys-%tky
                                           OverallStatus = 'X'   ) )
      REPORTED DATA(lt_travel).

    READ ENTITIES OF zi_travel_kashi_m IN LOCAL MODE
    ENTITY zi_travel_kashi_m
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result ( %tky = ls_result-%tky
                                               %param = ls_result ) ).
  ENDMETHOD.

ENDCLASS.
