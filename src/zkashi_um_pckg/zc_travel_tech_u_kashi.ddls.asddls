@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumptin view travel'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZC_Travel_tech_U_kashi 
provider contract transactional_query
as projection on ZI_TRAVAL_TECH_U_kashi
{  

  key TravelID,

      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency_StdVH', element: 'AgencyID'  }, useForValidation: true }]
      @ObjectModel.text.element: ['AgencyName']
      @Search.defaultSearchElement: true
      AgencyID,
      _Agency.Name       as AgencyName,

      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Customer_StdVH', element: 'CustomerID' }, useForValidation: true}]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      CustomerID,
      _Customer.LastName as CustomerName,

      BeginDate,

      EndDate,

      BookingFee,

      TotalPrice,

      @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
      CurrencyCode,

      Memo,

      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Travel_Status_VH', element: 'TravelStatus' }}]
      @ObjectModel.text.element: ['StatusText']  
      Status,
      
      _TravelStatus._Text.Text as StatusText : localized,

      LastChangedAt,
      /* Associations */

      _Booking : redirected to composition child ZC_Booking_tech_U_kashi,
      _Agency,
      _Currency,
      _Customer,
      _TravelStatus
      
     
}
