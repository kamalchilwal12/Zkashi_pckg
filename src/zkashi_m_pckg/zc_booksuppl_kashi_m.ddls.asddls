@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking supplement projection'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_booksuppl_kashi_m
  as projection on zi_booksuppl_kashi_m
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      @ObjectModel.text.element: [ 'supplementdesc' ]
      SupplementId,
      _supplementtext.Description as supplementdesc : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _booking : redirected to parent zc_booking_kashi_m, // redirected to the booking as a parent
      _supplement,
      _supplementtext,
      _travel  : redirected to zc_travel_kashi_m // redirected to the parent(root consumpiton/projection view
}
