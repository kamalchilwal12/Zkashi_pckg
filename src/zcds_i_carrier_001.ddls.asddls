@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds view for carrier deatils'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity zcds_i_carrier_001
  as select from /dmo/carrier
{
  key carrier_id    as CarrierId,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8 //this will search based on some value not with the entire value 
      name          as Name,
      currency_code as CurrencyCode
}
