@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connecetion'
}

define view entity zcds_I_connection_01
  as select from /dmo/connection as connection
  association [1..*] to zcds_i_flight_001 as _flight on  $projection.CarrierId    = _flight.CarrierId
                                                     and $projection.ConnectionId = _flight.ConnectionId
/* why we are using projection insted of the table field 
   bcz whatever result in the list output will be their we are refering those fields insted of
   refering to the connection table */
   association [1..1] to zcds_i_carrier_001 as _airline on $projection.CarrierId = _airline.CarrierId
{
      @UI.facet: [{ id : 'connection',
          purpose: #STANDARD,
          type: #IDENTIFICATION_REFERENCE,
          position: 10,
          label: 'Customer Details'  },
          { id : 'flight',
          purpose: #STANDARD,
          type: #LINEITEM_REFERENCE,
          position: 20,
          label: 'flight Details',
          targetElement: '_flight'  
        } ]

      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
      @ObjectModel.text.association: '_airline'// getting value from the association
  key carrier_id      as CarrierId,
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      airport_to_id   as AirportToId,
      @UI.identification: [{ position: 50 }]
      @UI.lineItem: [{ position: 50 }]
      departure_time  as DepartureTime,
      @UI.identification: [{ position: 60 }]
      @UI.lineItem: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.identification: [{ position: 70 }]
      distance        as Distance,
      @UI.identification: [{ position:  80}]
      distance_unit   as DistanceUnit,
      _flight,
      _airline
}
