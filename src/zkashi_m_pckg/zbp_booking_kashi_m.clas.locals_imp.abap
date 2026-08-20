CLASS lhc_zi_booking_kashi_m DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_booking_kashi_m RESULT result.

ENDCLASS.

CLASS lhc_zi_booking_kashi_m IMPLEMENTATION.

  METHOD get_instance_features.

  READ ENTITIES OF zi_travel_kashi_m  IN LOCAL MODE
    ENTITY zi_travel_kashi_m by \_booking
    FIELDS (  TravelId BookingStatus )
    with CORRESPONDING #( keys )
    result data(lt_booking).

    result = VALUE #( for ls_booking in lt_booking
                        ( %tky = ls_booking-%tky
                          %features-%assoc-_booksuppl = cond #( when ls_booking-BookingStatus = 'X'
                                                                    then if_abap_behv=>fc-o-disabled
                                                                    else if_abap_behv=>fc-o-enabled )
                          )  ).


  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

