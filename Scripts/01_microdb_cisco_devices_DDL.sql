/* -------------------------------------
 * ------ MICRODB CISCO DEVICES---------
 * -------------------------------------
 * 
 * 
 * ========= DDL =============
 */

-- DATABASE
drop database if exists microdb_cisco_devices;

create database microdb_cisco_devices;

use microdb_cisco_devices;

-- TABLES
drop table if exists rate_plans;
drop table if exists communication_plans;
drop table if exists devices;
drop table if exists devices_details;
drop table if exists device_audit_history;
drop table if exists device_usage;
drop table if exists device_usage_by_zone;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= Tabla rate_plans ===========

-- https://developer.cisco.com/docs/control-center/#!get-rate-plans/response-example
create table rate_plans(
	
id int auto_increment primary key,
name varchar(200) not null,
description varchar(500) not null,
version_id int not null,
version_plan varchar(20) default '1.1',
status enum('Published'
,'Active'
,'Inactive'),
type_plan varchar(200) not null,
subscription_charge decimal(6,3) default 2.99,
number_of_tiers int default 1,
creation_date datetime not null,
update_date datetime not null
);

-- ======= Restricciones Tabla rate_plans ===========

-- UNIQUE ID
alter table rate_plans 
add constraint UNIQUE_rate_plans_id
unique(id);

-- CHECK subscription_charge
alter table rate_plans
add constraint CHECK_rate_plans_subscription_charge
check (subscription_charge > 0.000);


-- CHECK UPDATE_DATE
alter table rate_plans
add constraint CHECK_rate_plans_update_date
check (update_date >= creation_date);

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= Tabla rate_plans ===========

-- https://developer.cisco.com/docs/control-center/#!get-rate-plans/response-example
create table communication_plans(
id int auto_increment primary key
);


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices ===========


create table devices(
	
id int auto_increment primary key,
iccid varchar(50) not null,
-- https://pubhub.devnetcloud.com/media/control-center-sandbox/docs/Content/api/rest/get_started_rest.htm#api_sim_status
status enum('ACTIVATION_READY'
, 'REPLACED'
, 'ACTIVATED'
, 'DEACTIVATED'
, 'INVENTORY'
, 'PURGED'
, 'RETIRED'
, 'TEST_READY') default 'ACTIVATION_READY',
rate_plan_id int default null,
communication_plan_id int default null,
creation_date datetime not null,
update_date datetime not null

);

-- ======= Restricciones Tabla devices ===========

-- UNIQUE ID
alter table devices 
add constraint UNIQUE_devices_id
unique(id);

-- FK rate_plan_id
alter table devices
add constraint FK_devices_rate_plan_id
foreign key(rate_plan_id)
references rate_plans(id)
ON DELETE CASCADE;

-- FK communication_plan_id
alter table devices 
add constraint FK_devices_communication_plan_id_id
foreign key(communication_plan_id)
references communication_plans(id)
ON DELETE CASCADE;

-- CHECK UPDATE_DATE
alter table devices
add constraint CHECK_rate_plans_update_date
check (update_date >= creation_date);


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_details ===========

-- https://developer.cisco.com/docs/control-center/#!get-device-details/response-example
create table devices_details(
	
id int auto_increment primary key,
device_id int not null,
imsi varchar(50) not null,
msisdn varchar(50) not null,
imei varchar(50) not null,
date_activated datetime not null,
date_added datetime not null,
date_updated datetime not null,
fixed_ip_adress varchar(50) default null,
fixed_ipv6_adress varchar(50) default null,
sim_notes varchar(200) default null,
device_mac varchar(255) default null,
creation_date datetime not null,
update_date datetime not null

);

-- ======= Restricciones Tabla devices_details ===========

-- UNIQUE ID
alter table devices_details 
add constraint UNIQUE_devices_details_id
unique(id);

-- FK id_device
alter table devices_details
add constraint FK_devices_details_device_id
foreign key(device_id)
references devices(id)
ON DELETE CASCADE;

-- CHECK UPDATE_DATE
alter table devices
add constraint CHECK_rate_plans_update_date
check (update_date >= creation_date);

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
