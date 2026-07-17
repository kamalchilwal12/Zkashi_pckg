@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connecetion'
}
@Search.searchable: true // added searchable field by which we can search the data in our list report

define view entity zcds_I_connection_01
  as select from /dmo/connection as connection
  association [1..*] to zcds_i_flight_001  as _flight  on  $projection.CarrierId    = _flight.CarrierId
                                                       and $projection.ConnectionId = _flight.ConnectionId
  /* why we are using projection insted of the table field
     bcz whatever result in the list output will be their we are refering those fields insted of
     refering to the connection table */
  association [1..1] to zcds_i_carrier_001 as _airline on  $projection.CarrierId = _airline.CarrierId

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

    //  @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
      @ObjectModel.text.association: '_airline'// getting value from the association
      @Search.defaultSearchElement: true // making this field value searchable
  key carrier_id      as CarrierId,
     // @UI.selectionField: [{ position: 20 }] // as we can not use change the label value in the selection field as it's taking from
     // the data element we can use @EndUserText.label: 'Text' which will change the value every where like : object page,selection etc
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      @Search.defaultSearchElement: true
      @UI.selectionField: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zcds_i_airport_vh_01', // added value help from the cds for the below field
                                                     element: 'AirportId' } } ]
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @UI.selectionField: [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zcds_i_airport_vh_01', // added value help from the cds for the below field
                                                     element: 'AirportId' } } ]
      @EndUserText.label: 'Dest Airport ID' // this will change the lable value in facet ,selection field ,list report,object page etc 
      //insted of doing it everywhere in the annotation                                    
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
      @Search.defaultSearchElement: true 
      _flight,
      @Search.defaultSearchElement: true // made this association value serachable and also added the search value in the associated
      // cds
      _airline
}
