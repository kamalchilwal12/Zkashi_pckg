@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption view for approval'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_travel_approval_kashi_m 
provider contract transactional_query
as projection on zi_travel_kashi_m
{
    key TravelId,
    AgencyId,
    CustomerId,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    OverallStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _agency,
    _booking: redirected to composition child zc_booking_approval_kashi_m,
    _currency,
    _customer,
    _status
}
