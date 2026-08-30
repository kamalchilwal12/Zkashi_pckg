@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'root view entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_Employee_hr_data 
as select from zcds_emp_detail
//composition of target_data_source_name as _association_name
{
    key employee_id as EmployeeId,
    name as Name,
    department as Department,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    salary as Salary,
    currency_code as CurrencyCode
}
