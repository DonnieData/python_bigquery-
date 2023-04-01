-- view for service_requests by type
create view `qwiklabs-gcp-03-78402af0367f.l2_datasets.service_type_dept` as (
  select department, count(service_request_number) service_count from `qwiklabs-gcp-03-78402af0367f.l1_datasets.311_data`
  group by department 
  order by service_count desc
)

