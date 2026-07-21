@EndUserText.label: 'custom entity for employee hr data'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_ADF_EMPLOYEE_KASHI'
define custom entity zce_employee_hr_kashi
  // with parameters parameter_name : parameter_type
{
  key employee    : /dmo/employee_id;
      @Semantics.largeObject: {
          mimeType: 'MimeType',
          fileName: 'FileName',
          contentDispositionPreference: #ATTACHMENT }
      FormContent : abap.rawstring( 0 );
      FileName    : abap.char( 128 );
      MimeType    : abap.char( 128 );
}
