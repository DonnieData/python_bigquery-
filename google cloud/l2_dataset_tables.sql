--L2
--no timezone imforation provided so datetime used instead of timestamp to prevent from converting ot UTC
create table `[project_id].l2_tables.311_transformed` as (
select 
* 
,datetime(created_date) created_date_t
,datetime(overall_service_request_due_date) overall_service_request_due_date_t
,datetime(update_date) update_date_t
,ifnull(datetime(closed_date),current_datetime()) closed_date_t
,right(address,5) zipcode

from `[project_id].l1_tables.311_data`
)

--L3
-- table for service_requests by department
create table `[project_id].l3_datasets.service_type_dept` as (
  select department, count(service_request_number) service_count from `[project_id].l2_tables.311_transformed`
  group by department 
  order by service_count desc
)

-- table for service_requests by status
create table `[project_id].l3_tables.service_by_status` as (
  select status, count(service_request_number) service_count from `[project_id].l2_tables.311_transformed`
  group by status 
  order by service_count desc
)

-- service_requests count by zipcode 
select zipcode, count(service_request_number)
from `donni12.l1_data.base_table`
group by zipcode 




