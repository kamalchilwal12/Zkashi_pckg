@EndUserText.label: 'table function'
define table function ztf_testing_tf
with parameters created_by      : abp_creation_user 
returns {
client      : abap.clnt;
  travel_id   : /dmo/travel_id;
  agency_id       : /dmo/agency_id;
  customer_id     : /dmo/customer_id;
  begin_date      : /dmo/begin_date;
  end_date        : /dmo/end_date;
  
}
implemented by method zcl_travel_kashi_det=>get_data;