-- view for service_requests by type
create table `qwiklabs-gcp-03-78402af0367f.l2_datasets.service_type_dept` as (
  select department, count(service_request_number) service_count from `qwiklabs-gcp-03-78402af0367f.l1_datasets.311_data`
  group by department 
  order by service_count desc
)

-- view for service_requests by status
create table `qwiklabs-gcp-03-78402af0367f.l2_datasets.service_by_status` as (
  select status, count(service_request_number) service_count from `qwiklabs-gcp-03-78402af0367f.l1_datasets.311_data`
  group by status 
  order by service_count desc
)


--no timezone imforation provided so datetime used instead of timestamp to prevent from converting ot UTC
with base_table as (
select 
* 
,datetime(created_date) created_date_t
,datetime(overall_service_request_due_date) overall_service_request_due_date_t
,datetime(update_date) update_date_t
,ifnull(datetime(closed_date),current_datetime()) closed_date_t
from `donni12.l1_data.311_data`
)

select * from base_table
