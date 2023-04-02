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
,case 
when status = 'Closed' then 'Closed'
when status = 'Closed (Transferred)' then 'Closed'
when status = 'Closed (Duplicate)' then 'Closed'
when status = 'In Progress' then 'Open'
when status = 'New' then 'Open'
when status = 'In Progress (Duplicate)' then 'Open'
when status = 'New (Duplicate)' then 'Open'
when status = 'On Hold' then 'Open'
when status = 'On Hold (Duplicate)' then 'Open'
end status_second
from `[project_id].l1_tables.311_data`
)

--L3
-- table for service_requests by department
create table `[project_id].l3_datasets.service_request_by_dept` as (
  select department, count(service_request_number) service_count from `[project_id].l2_tables.311_transformed`
  group by department 
  order by service_count desc
)

-- table for service_requests by status
create table `[project_id].l3_tables.service_by_status` as (
  select status_second, status, count(service_request_number) service_count from `[project_id].l2_tables.311_transformed`
  group by status_second, status 
  order by service_count desc
)

-- service_requests count by zipcode 
select zipcode, count(service_request_number)
from `[project_id].l2_tables.311_transformed`
group by zipcode 

--service requests by type 
select service_request_type, count(service_request_number)
from `[project_id].l2_tables.311_transformed`
group by service_request_type 

-- day of week and hour for service request creation 
create table `[project_id].l3_tables.service_creation_date_metrics` (
select 
created_date_t
,format_date('%a',created_date_t) created_weekday
,extract(hour from created_date_t) created_hour
 ,format_date('%b', created_date_t) created_month
from `[project_id].l2_tables.311_transformed`
)

--


