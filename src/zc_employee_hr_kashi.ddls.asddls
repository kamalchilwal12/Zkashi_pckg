@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for zemployee hr'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_employee_hr_kashi 
provider contract transactional_query
as projection on zi_employee_hr_kashi
{
    key Employee,
    FirstName,
    LastName,
    @Semantics.amount.currencyCode: 'SalaryCurrency'
    Salary,
    SalaryCurrency,
    Manager,
    FormURL,
    form
}
