@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds view for carrier deatils'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_i_carrier_001
  as select from /dmo/carrier
{
  key carrier_id    as CarrierId,
      @Semantics.text: true
      name          as Name,
      currency_code as CurrencyCode
}
