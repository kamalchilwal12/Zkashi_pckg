@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking projection'
@Metadata.ignorePropagatedAnnotations: true
define view entity zc_booking_kashi_m as projection on zi_booking_kashi_m
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    LastChangedAt,
    /* Associations */
    _booking_status,
    _booksuppl: redirected to composition child zc_booksuppl_kashi_m,
    _carrier,
    _connection,
    _customer,
    _travel: redirected to parent zc_travel_kashi_m // redirecting to the parent
}
