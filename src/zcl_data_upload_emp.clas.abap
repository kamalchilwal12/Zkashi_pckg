CLASS zcl_data_upload_emp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_upload_emp IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DELETE FROM zemployee_hr_kas.
    COMMIT WORK.
    SELECT * FROM /dmo/employee_hr INTO TABLE @DATA(lt_employee).
    INSERT zemployee_hr_kas FROM TABLE @lt_employee.
    COMMIT WORK.



  ENDMETHOD.
ENDCLASS.
