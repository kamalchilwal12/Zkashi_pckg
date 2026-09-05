CLASS lhc_zi_kashi_rap_book DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zi_kashi_rap_book RESULT result.

ENDCLASS.

CLASS lhc_zi_kashi_rap_book IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
