@EndUserText.label: 'abstract entity'
define abstract entity ZSalaryHikeRequest
//  with parameters parameter_name : parameter_type
{
   // element_name : element_type;
    employeeId  : abap.numc(10);
    hikePercent : abap.dec(5,2);
    
}
