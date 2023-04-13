--L2
--no timezone imforation provided so datetime used instead of timestamp to prevent from converting ot UTC
create table `[project_id].l2_tables.311_transformed` as (
with table1 as (select 
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
from `[project_id].l1_tables.311_data` ),

table2 as (select 
*
,date_diff(closed_date_t,created_date_t, day) created_closed 
,date_diff(update_date_t,created_date_t, day) created_updated
,date_diff(overall_service_request_due_date_t,created_date_t, day) created_due_date
from table1) 


select 
*
, round(created_closed/10)*10  created_closed_bucket
,round(created_updated/10)*10  created_updated_bucket
,round(created_due_date/10)*10  created_due_bucket
 from table2
 ) 

--L3
-- table for service_requests by department
create table `[project_id].l3_tables.service_request_by_dept` as (
  select department, count(service_request_number) service_count from `[project_id].l2_tables.311_transformed`
  group by department 
  order by service_count desc
);

-- table for service_requests by status
create table `[project_id].l3_tables.service_by_status` as (
  select status_second, status, count(service_request_number) service_count from `[project_id].l2_tables.311_transformed`
  group by status_second, status 
  order by service_count desc
);

-- service_requests count by zipcode 
create table `[project_id].l3_tables.service_by_zipcode` as (
 select zipcode, count(service_request_number) service_request_count
from `[project_id].l2_tables.311_transformed`
group by zipcode);

--service requests by type 
create table `[project_id].l3_tables.service_by_type` as (
select service_request_type, count(service_request_number) service_request_count
from `[project_id].l2_tables.311_transformed`
group by service_request_type 
order by service_request_count desc );

-- day of week and hour for service request creation 
create table `[project_id].l3_tables.service_creation_date_metrics` as (
select 
format_date('%b', created_date_t) created_month
,format_date('%a',created_date_t) created_weekday
,extract(hour from created_date_t) created_hour
 ,count(service_request_number) request_count
from `[project_id].l2_tables.311_transformed`
 group by created_month, created_weekday, created_hour
);


-- topline metrics 
create table `[project_id].l3_tables.service_metrics` as (
with total_records as ( 
  select count(service_request_number) count from `[project_id].l2_tables.311_data_transformed`
)

select 
  (select count from total_records)service_request_count
  ,(select max(created_due_date) from `[project_id].l2_tables.311_transformed`) max_created_due_date
  ,(select min(created_due_date) from `[project_id].l2_tables.311_transformed`) min_created_due_date
  ,(select round(avg(created_updated)) from `[project_id].l2_tables.311_transformed`) avg_created_update
  ,(select min(created_closed) from `[project_id].l2_tables.311_transformed`) min_created_closed
  ,(select max(created_closed) from `[project_id].l2_tables.311_transformed`) max_created_closed
  ,(select round(count(service_request_number)/12) from `[project_id].l2_tables.311_transformed`) avg_request_per_month

  ,(select round(avg(created_due_date)) from `[project_id].l2_tables.311_transformed`) avg_created_due_date
);

-- service requests by outcome
create table `[project_id].l3_tables.service_outcomes` as (
select outcome, count(service_request_number) service_count from `[project_id].l2_tables.311_transformed`
group by outcome 
order by service_count desc 
)



  







