@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connecetion'
}

define view entity zcds_I_connection_01 as select from /dmo/connection
{
    @UI.facet: [{ purpose: #STANDARD,
        type: #IDENTIFICATION_REFERENCE,
        position: 10,
        label: 'Customer Details'  }]
        
    @UI.selectionField: [{ position: 10 }]
    @UI.lineItem: [{ position: 10 }]
    @UI.identification: [{ position: 10 }]
    key carrier_id as CarrierId,
    @UI.selectionField: [{ position: 20 }]
    @UI.lineItem: [{ position: 20 }]
    @UI.identification: [{ position: 20 }]
    key connection_id as ConnectionId,
    @UI.lineItem: [{ position: 30 }]
    @UI.identification: [{ position: 30 }]
    airport_from_id as AirportFromId,
    @UI.lineItem: [{ position: 40 }]
    @UI.identification: [{ position: 40 }]
    airport_to_id as AirportToId,
    @UI.identification: [{ position: 50 }]
    @UI.lineItem: [{ position: 50 }]
    departure_time as DepartureTime,
    @UI.identification: [{ position: 60 }]
    @UI.lineItem: [{ position: 60 }]
    arrival_time as ArrivalTime,
    @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
    @UI.identification: [{ position: 70 }]
    distance as Distance,
    @UI.identification: [{ position:  80}]
    distance_unit as DistanceUnit
}
