@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption travel or projection view'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_travel_kashi_m 
provider contract transactional_query
as projection on zi_travel_kashi_m
{
    key TravelId,
    @ObjectModel.text.element: [ 'AgencyName' ]
    AgencyId,
    _agency.Name as AgencyName,
    @ObjectModel.text.element: [ 'CustomerName' ]
    CustomerId,
    _customer.LastName as CustomerName,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    @ObjectModel.text.element: [ 'overallstatustext' ]
    OverallStatus,
    _status._Text.Text as overallstatustext : localized ,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _agency,
    _booking: redirected to composition child zc_booking_kashi_m,// to skip the provider contract for the child node 
    _currency,
    _customer,
    _status
}
