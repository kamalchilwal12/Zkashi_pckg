CLASS lhc_ZI_Employee_hr_data DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR ZI_Employee_hr_data RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR ZI_Employee_hr_data RESULT result.

    METHODS approveHike FOR MODIFY
       keys FOR ACTION ZI_Employee_hr_data~approveHike RESULT result.

ENDCLASS.

CLASS lhc_ZI_Employee_hr_data IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD approveHike.
   LOOP AT keys INTO DATA(key).

      "Read current employee data
      READ ENTITIES OF ZI_Employee_hr_data IN LOCAL MODE
        ENTITY employee
        FIELDS ( Salary )
        WITH VALUE #( ( %tky = key-%tky ) )
        RESULT DATA(lt_employee).

      READ TABLE lt_employee INTO DATA(ls_employee) INDEX 1.

      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      "Calculate new salary
      DATA(lv_new_salary) =
          ls_employee-Salary +
          ( ls_employee-Salary * key-%param-hikePercent / 100 ).

      "Update employee
      MODIFY ENTITIES OF ZI_Employee_hr_data IN LOCAL MODE
        ENTITY Employee
        UPDATE FIELDS ( Salary )
        WITH VALUE #(
          ( %tky   = key-%tky
            Salary = lv_new_salary )
        ).

      "Return result
      READ ENTITIES OF ZI_Employee_hr_data IN LOCAL MODE
        ENTITY Employee
        ALL FIELDS
        WITH VALUE #( ( %tky = key-%tky ) )
        RESULT DATA(lt_result).

      result = VALUE #(
        FOR employee IN lt_result
        (
          %tky = key-%tky
          %param = employee
        )
      ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
