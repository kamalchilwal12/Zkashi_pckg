CLASS zcl_adf_employee_kashi DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_adf_employee_kashi IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA: lv_employee  TYPE zi_employee_hr_kashi-Employee,
          lt_form_data TYPE STANDARD TABLE OF zce_employee_hr_kashi.

    TRY.
        DATA(lt_filter) = io_request->get_filter( )->get_as_ranges( ).
        DATA(ls_filter) = VALUE #( lt_filter[ name = 'EMPLOYEE' ] OPTIONAL ).

        IF ls_filter-range[] IS NOT INITIAL.
          lv_employee = VALUE #( ls_filter-range[ 1 ]-low OPTIONAL ).
        ENDIF.

      CATCH cx_rap_query_filter_no_range.
        RETURN.

    ENDTRY.

    IF lv_employee IS INITIAL.
      RETURN.
    ENDIF.

    try.
    "get form layout
     data(lo_form_reader) = cl_fp_form_reader=>create_form_reader(  iv_formname = 'ZADB_F_EMPLOYEE' ).
     data(lv_form_layout) = lo_form_reader->get_layout(  ).

     "get form data
     data(lo_form_object) = cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZSD_EMPLOYEE_HR_KASHI'
                                                              iv_max_depth = 5     ).
     data(lt_form_keys) = lo_form_object->get_keys( ).
     data(lr_form_keys) = ref #( lt_form_keys[ name = 'EMPLOYEE' ] optional ).

     if lr_form_keys is bound.
     lr_form_keys->value = lv_employee.
     endif.

     data(lv_form_xml_data) = lo_form_object->read_to_xml( it_select = lt_form_keys ).
     catch cx_fp_form_reader cx_fp_fdp_error.
     return.

    ENDTRY.

    "render form PDF
    try.
        cl_fp_ads_util=>render_pdf( exporting  iv_xml_data = lv_form_xml_data
                                                iv_xdp_layout = lv_form_layout
                                                iv_locale = 'es_US'
                                     IMPORTING  ev_pdf = data(lv_pdf) ).

    catch cx_fp_ads_util into data(ox_fp_ads_util).

    ENDTRY.

    "send data back to front end.

    lt_form_data = value #( (
                employee = lv_employee
                FormContent = lv_pdf
                FileName = |form_{ lv_employee }.pdf|
                MimeType = 'application/pdf' ) ).

    try.
        io_response->set_data( it_data = lt_form_data ).
        io_response->set_total_number_of_records(
            iv_total_number_of_records = lines( lt_form_data ) ).

        catch cx_rap_query_response_set_twic.
    endtry.


  ENDMETHOD.

ENDCLASS.
