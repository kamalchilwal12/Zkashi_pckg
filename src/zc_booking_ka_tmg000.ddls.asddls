@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZBOOKING_KA_TMG'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BOOKING_KA_TMG000
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_BOOKING_KA_TMG000
  association [1..1] to ZR_BOOKING_KA_TMG000 as _BaseEntity on $projection.TRAVELID = _BaseEntity.TRAVELID and $projection.BOOKINGID = _BaseEntity.BOOKINGID
{
  key TravelID,
  key BookingID,
  BookingDate,
  CustomerID,
  CarrierID,
  ConnectionID,
  FlightDate,
  @Semantics: {
    Amount.Currencycode: 'CurrencyCode'
  }
  FlightPrice,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  CurrencyCode,
  BookingStatus,
  @Semantics: {
    User.Createdby: true
  }
  Localcreatedby,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  Localcreatedat,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  Locallastchangedby,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Locallastchangedat,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  Lastchangedat,
  _BaseEntity
}
