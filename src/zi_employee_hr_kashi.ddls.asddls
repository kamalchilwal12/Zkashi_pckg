@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'employye interface'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zi_employee_hr_kashi
  as select from zemployee_hr_kas
  //composition of target_data_source_name as _association_name
{
  key employee        as Employee,
      first_name      as FirstName,
      last_name       as LastName,
      @Semantics.amount.currencyCode: 'SalaryCurrency'
      salary          as Salary,
      salary_currency as SalaryCurrency,
      manager         as Manager,
      
      concat( '/sap/opu/odata4/sap/zsb_form_emp_hr_kashi/srvd_a2x/sap/zsd_ce_emp_hr_kashi/0001/ADF_EMPLOYEE(''',
               concat( employee, ''')/FormContent' ) ) as FormURL,
              'Print Form' as form


}
