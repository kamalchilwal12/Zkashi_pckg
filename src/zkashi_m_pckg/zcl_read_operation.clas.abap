CLASS zcl_read_operation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_read_operation IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
 " sort from read.
 "READ entity zi_travel_kashi_m from value #( ( %key-TravelId = '4220' ) )
 "result data(lt_result_sort)
 "failed data(lt_failed_sort).


 "other ways
 "READ entity zi_travel_kashi_m fields ( AgencyId BeginDate BookingFee )
 "with value #( ( %key-TravelId = '4220' ) )
 "result data(lt_result_sort)
 "failed data(lt_failed_sort).


 "read by association
" READ entity zi_travel_kashi_m
 "by \_booking
 "ALL FIELDS
" with value #( ( %key-TravelId = '2976' ) )
 "result data(lt_result_sort)
 "failed data(lt_failed_sort).

 "multiple entites read
  READ ENTITIES  of zi_travel_kashi_m "root entity
  entity zi_travel_kashi_m
 ALL FIELDS
 with value #( ( %key-TravelId = '2976' ) )
 result data(lt_result_sort)

 ENTITY zi_booking_kashi_m
 ALL FIELDS
 with value #( ( %key-TravelId = '2976'
                 %key-BookingId = '1' ) )
 result data(lt_result_book_sort)
 failed data(lt_failed_sort).

    if lt_failed_sort is NOT INITIAL.
        out->write( 'Read Failed' ).
        else.
        out->write( lt_result_sort ).
        out->write( lt_result_book_sort ).
    endif.

  ENDMETHOD.

ENDCLASS.
