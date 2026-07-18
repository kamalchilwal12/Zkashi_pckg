@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking projection'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_booking_kashi_m
  as projection on zi_booking_kashi_m
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element:  ['CustomerName']
      CustomerId,
      _customer.LastName as CustomerName,
      @ObjectModel.text.element:  ['CarrierName']
      CarrierId,
      _carrier.Name      as CarrierName,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element:  ['bookingstatustext']
      BookingStatus,
      _booking_status._Text.Text as bookingstatustext :localized, 
      LastChangedAt,
      /* Associations */
      _booking_status,
      _booksuppl : redirected to composition child zc_booksuppl_kashi_m,
      _carrier,
      _connection,
      _customer,
      _travel    : redirected to parent zc_travel_kashi_m // redirecting to the parent
}
