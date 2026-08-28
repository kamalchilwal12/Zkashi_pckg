CLASS zcl_application_job_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES : IF_APJ_DT_EXEC_OBJECT,
               IF_APJ_RT_EXEC_OBJECT.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_application_job_test IMPLEMENTATION.

   METHOD if_apj_dt_exec_object~get_parameters.
    et_parameter_def = value #(
      ( selname = 'P_STORID' kind = if_apj_dt_exec_object=>parameter
        component_type = 'ZBOOKSTORE_ID'  length = 3
        changeable_ind = abap_true mandatory_ind = abap_true )
      ( selname = 'S_BOOKID' kind = if_apj_dt_exec_object=>select_option
        component_type = 'ZBOOK_ID'       length = 6
        changeable_ind = abap_true mandatory_ind = abap_true )
      ( selname = 'P_REORQT' kind = if_apj_dt_exec_object=>parameter
        datatype = 'I' length = 3 param_text = 'Reorder Qty'
        changeable_ind = abap_true mandatory_ind = abap_true )
      ( selname = 'P_SIMUL'  kind = if_apj_dt_exec_object=>parameter
        datatype = 'C' length = 1 param_text = 'Simulate Only'
        changeable_ind = abap_true checkbox_ind  = abap_true )
    ).

     et_parameter_val = value #(
      ( selname = 'P_REORQT' kind = if_apj_dt_exec_object=>parameter
        sign = 'I' option = 'EQ' low = '10' )
    ).

  ENDMETHOD.

  METHOD if_apj_rt_exec_object~execute.

*            " data:" lrt_book type range of zbook_id,
*         " lrs_book          like line of lrt_book,
*          "lv_bookstore      type zbookstore_id,
**          lv_reorder_qty    type zbooks_in_stock,
**          lv_simulate       type c length 1,
**          lt_update         type table for update zr_bookstorestocktp\\bookstorestock,
**          lt_create         type table for create zr_bookstorestocktp\\bookstorestock,
**          ls_update         type structure for update zr_bookstorestocktp\\bookstorestock,
**          ls_create         type structure for create zr_bookstorestocktp\\bookstorestock,
**          lt_reported       type response for reported early zr_bookstorestocktp,
**          lt_failed         type response for failed early zr_bookstorestocktp,
**          ls_bookstore_book type zi_bookstorestock,
**          lv_create         type c length 1.
*
*    try.
*        " handle log
*        if sy-batch = abap_true.
*          " if we are running in background, we create application log
*          go_log = cl_bali_log=>create_with_header(
*            header = cl_bali_header_setter=>create(
*              object    = 'ZBOOKSTORE_01_LOG'
*              subobject = 'ZBOOKSTORE_01_SUB' ) ).
*          add_text_to_log( 'start job' ).
*          final(lv_log_handle) = go_log->get_handle( ).
*          add_text_to_log( |log handle: { lv_log_handle }| ).
*        else.
*          add_text_to_log( 'start job' ).
*          add_text_to_log( |foreground run, no log created| ).
*        endif.

        " Going through job parameter values
        loop at it_parameters into data(ls_parameter).
*          case ls_parameter-selname.
*            when 'S_BOOKID'.
*              append value #( sign   = ls_parameter-sign
*                              option = ls_parameter-option
*                              low    = conv #( ls_parameter-low  )
*                              high   = conv #( ls_parameter-high ) )
*                to lrt_book.
*            when 'P_STORID'.
*              lv_bookstore = conv #( ls_parameter-low ).
*            when 'P_REORQT'.
*              lv_reorder_qty = conv #( ls_parameter-low ).
*            when 'P_SIMUL'.
*              lv_simulate = ls_parameter-low.
*          endcase.
        endloop.

        " get bookstore for which reorder was requested
*        select single * from zr_bookstores
*          where bookstoreid = _bookstore
*          into (ls_bookstore).
*        if sy-subrc <> 0.
*          add_text_to_log( |bookstore not found with id: { lv_bookstore }| ).
*        else.
*          " go through books...
*          loop at lrt_book into lrs_book.
*            clear: lv_create, ls_bookstore_book, ls_update, ls_create.
*            " check if bookstore already has the current book
*            if lrs_book-option = 'EQ'. " only handling EQ!
*              add_text_to_log( |processing book with id: { lrs_book-low }| ).
*              select single * from zi_bookstorestock
*                where bookstoreid = _bookstore
*                  and bookid      = _book-low
*                into _bookstore_book.
*              if sy-subrc <> 0.
*                " book is not yet in bookstore, check if book exists...
*                select single  from zi_books
*                  where bookid = _book-low
*                  into (lv_exists).
*                if sy-subrc = 0.
*                  " book needs to be added (created) to bookstore
*                  lv_create = abap_true.
*                  ls_bookstore_book = value #( bookstoreid = lv_bookstore
*                    bookid = lrs_book-low booksinstore = 0 booksinstock = 0 ).
*                else.
*                  add_text_to_log( |book does not exit and is ignored: { lrs_book-low }| ).
*                  continue.
*                endif.
*              endif.
*              add_text_to_log( |stock qty. before: { ls_bookstore_book-booksinstock }| ).
*              ls_bookstore_book-booksinstock += lv_reorder_qty.
*              add_text_to_log( |stock qty. after: { ls_bookstore_book-booksinstock }| ).
*              " set if we create or update the bookstore stock RAP BO
*              if lv_create = abap_true.
*                ls_create = corresponding #( ls_bookstore_book ).
*                append ls_create to lt_create.
*              else.
*                ls_update = corresponding #( ls_bookstore_book ).
*                append ls_update to lt_update.
*              endif.
*            endif.
*          endloop.
*          if sy-subrc <> 0.
*            add_text_to_log( 'no books to reorder specified' ).
*          endif.
*        endif.
*
*        " UPDATE or SIMULATION ----------------------------------------------
*        if lv_simulate = abap_true.
*          add_text_to_log( 'SIMULATION only, no changes saved' ).
*        else.
*          " change data -----------------------------------------------------
*          if lt_update is not initial.
*            modify entities of zr_bookstorestocktp
*                 entity bookstorestock
*                   update fields ( booksinstock ) with lt_update
*                reported data(update_reported)
*                failed data(update_failed).
*            if update_failed is initial.
*              " commit change
*              commit entities response of zr_bookstorestocktp
*                reported data(commit_reported1)
*                failed data(commit_failed1).
*              " set errors if commit failed
*              lt_reported = corresponding #( deep commit_reported1 ).
*              lt_failed = corresponding #( deep commit_failed1 ).
*            else.
*              " set error
*              lt_reported = corresponding #( update_reported ).
*              lt_failed = corresponding #( update_failed ).
*            endif.
*          endif.
*          " create data -----------------------------------------------------
*          if lt_create is not initial.
*            modify entities of zr_bookstorestocktp
*                 entity bookstorestock
*                   create
*                   fields ( bookstoreid bookid booksinstock booksinstore )
*                auto fill cid with lt_create
*                reported data(create_reported)
*                failed data(create_failed).
*            if create_failed is initial.
*              " commit created
*              commit entities response of zr_bookstorestocktp
*                reported data(commit_reported2)
*                failed data(commit_failed2).
*              " set errors if commit failed
*              lt_reported = corresponding #( deep commit_reported2 ).
*              lt_failed = corresponding #( deep commit_failed2 ).
*            else.
*              " set error
*              lt_reported = corresponding #( create_reported ).
*              lt_failed = corresponding #( create_failed ).
*            endif.
*          endif.
*        endif.
*
*        if lt_failed is initial.
*          " SUCCESS -------------------------------
*          add_text_to_log( |commit success, nothing in failed| ).
*
*        else.
*          " ERRORS --------------------------------
*          loop at lt_failed-bookstorestock into data(ls_failed).
*            add_text_to_log( |failed to modify bookstore { ls_failed-bookstoreid } with book { ls_failed-bookid }| ).
*            add_text_to_log( |reason: { ls_failed-%fail-cause }| ).
*          endloop.
*        endif.
*
*        add_text_to_log( |job finished| ).
*
*      catch cx_bali_runtime into data(lx_bali_exception).
*
*        data(lv_log_exception) = lx_bali_exception->get_text(  ).
*        raise exception type cx_apj_rt_content
*          exporting
*            previous = lx_bali_exception.
*
*    endtry.

  ENDMETHOD.



ENDCLASS.
