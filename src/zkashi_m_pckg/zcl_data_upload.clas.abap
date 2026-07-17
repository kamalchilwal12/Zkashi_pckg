CLASS zcl_data_upload DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_upload IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DELETE FROM ztravel_kashi_m.
    DELETE FROM zbooking_kashi_m.
    DELETE FROM zbooksupp_kash_m.
    COMMIT WORK.
    SELECT * FROM /dmo/travel_m INTO TABLE @DATA(lt_travel).
    INSERT ztravel_kashi_m FROM TABLE @lt_travel.
    COMMIT WORK.

    SELECT * FROM /dmo/booking_m INTO TABLE @DATA(lt_booking).
    INSERT zbooking_kashi_m FROM TABLE @lt_booking.
    COMMIT WORK.

    SELECT * FROM /dmo/booksuppl_m INTO TABLE @DATA(lt_booksupp).
    INSERT zbooksupp_kash_m FROM TABLE @lt_booksupp.
    COMMIT WORK.

  ENDMETHOD.
ENDCLASS.
