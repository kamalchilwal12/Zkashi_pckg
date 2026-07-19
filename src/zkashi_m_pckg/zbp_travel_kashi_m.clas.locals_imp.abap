CLASS lhc_zi_travel_kashi_m DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_kashi_m RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_travel_kashi_m RESULT result.

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

ENDCLASS.
