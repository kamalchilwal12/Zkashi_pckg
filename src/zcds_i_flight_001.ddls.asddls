@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface cds view for flight details'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_i_flight_001
  as select from /dmo/flight
  association [1..1] to zcds_i_carrier_001 as _airline on $projection.CarrierId = _airline.CarrierId
{
      @UI.lineItem: [{ position: 10 }]
      @ObjectModel.text.association: '_airline'// getting value from the association
  key carrier_id     as CarrierId,
      @UI.lineItem: [{ position: 20 }]
  key connection_id  as ConnectionId,
      @UI.lineItem: [{ position: 30 }]
  key flight_date    as FlightDate,
      @UI.lineItem: [{ position: 40 }]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      @UI.lineItem: [{ position: 50 }]
      currency_code  as CurrencyCode,
      @UI.lineItem: [{ position: 60 }]
      plane_type_id  as PlaneTypeId,
      @UI.lineItem: [{ position: 70 }]
      seats_max      as SeatsMax,
      @UI.lineItem: [{ position: 80 }]
      seats_occupied as SeatsOccupied,
      _airline
}
