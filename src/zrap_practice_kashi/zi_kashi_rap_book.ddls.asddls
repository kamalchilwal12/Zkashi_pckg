@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'root / interface view for travel booking'
@Metadata.allowExtensions: true
//@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_kashi_rap_book as select from zkashi_rap_book
//composition of target_data_source_name as _association_name
{
    key travel_id as TravelId,
    key booking_id as BookingId,
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    flight_price as FlightPrice,
    currency_code as CurrencyCode
  //  _association_name // Make association public
}
