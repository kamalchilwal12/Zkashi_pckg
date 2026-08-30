CLASS lhc_ZI_TRAVAL_TECH_U_kashi DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR ZI_TRAVAL_TECH_U_kashi RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR ZI_TRAVAL_TECH_U_kashi RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE ZI_TRAVAL_TECH_U_kashi.

    METHODS update FOR MODIFY
       entities FOR UPDATE ZI_TRAVAL_TECH_U_kashi.

    METHODS delete FOR MODIFY
       keys FOR DELETE ZI_TRAVAL_TECH_U_kashi.

    METHODS read FOR READ
       keys FOR READ ZI_TRAVAL_TECH_U_kashi RESULT result.

    METHODS lock FOR LOCK
       keys FOR LOCK ZI_TRAVAL_TECH_U_kashi.

    METHODS rba_Booking FOR READ
       keys_rba FOR READ ZI_TRAVAL_TECH_U_kashi\_Booking FULL result_requested RESULT result LINK association_links.

    METHODS cba_Booking FOR MODIFY
       entities_cba FOR CREATE ZI_TRAVAL_TECH_U_kashi\_Booking.

ENDCLASS.

CLASS lhc_ZI_TRAVAL_TECH_U_kashi IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Booking.
  ENDMETHOD.

  METHOD cba_Booking.
  ENDMETHOD.

ENDCLASS.
