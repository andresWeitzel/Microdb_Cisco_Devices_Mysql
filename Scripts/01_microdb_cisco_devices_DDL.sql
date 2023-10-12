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
drop table if exists devices;
drop table if exists devices_details;
drop table if exists devices_audit_history;
drop table if exists devices_usage;
drop table if exists devices_cycle_usage_by_zone;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= Tabla rate_plans ===========

-- https://developer.cisco.com/docs/control-center/#!get-rate-plans/response-example
create table rate_plans(
	
id bigint auto_increment primary key,
name varchar(200) not null,
description varchar(500) not null,
version_id int not null,
version_plan varchar(20) default '1.1',
status enum('Published'
,'Active'
,'Inactive') default 'ACTIVE',
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

-- UNIQUE VERSION_ID
alter table rate_plans 
add constraint UNIQUE_rate_plans_version_id
unique(version_id);

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


-- ======= Tabla devices ===========


create table devices(
	
id bigint auto_increment primary key,
iccid varchar(50) not null,
-- https://pubhub.devnetcloud.com/media/control-center-sandbox/docs/Content/api/rest/get_started_rest.htm#api_sim_status
status enum('ACTIVATION_READY'
, 'REPLACED'
, 'ACTIVATED'
, 'DESACTIVATED'
, 'INVENTORY'
, 'PURGED'
, 'RETIRED'
, 'TEST_READY') default 'ACTIVATION_READY',
rate_plan_id bigint default null,
creation_date datetime not null,
update_date datetime not null

);

-- ======= Restricciones Tabla devices ===========

-- UNIQUE ID
alter table devices 
add constraint UNIQUE_devices_id
unique(id);

-- UNIQUE ICCID
alter table devices 
add constraint UNIQUE_devices_iccid
unique(iccid);

-- FK rate_plan_id
alter table devices
add constraint FK_devices_rate_plan_id
foreign key(rate_plan_id)
references rate_plans(id)
on update cascade on delete cascade;

-- CHECK UPDATE_DATE
alter table devices
add constraint CHECK_rate_plans_update_date
check (update_date >= creation_date);


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_details ===========

-- https://developer.cisco.com/docs/control-center/#!get-device-details/response-example
create table devices_details(
	
id bigint auto_increment primary key,
device_id bigint not null,
imsi varchar(50) not null,
msisdn varchar(50) not null,
imei varchar(50) not null,
date_activated datetime not null,
date_added datetime not null,
date_updated datetime not null,
fixed_ip_adress varchar(50) default null,
fixed_ipv6_adress varchar(255) default null,
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

-- UNIQUE DEVICES_ID
alter table devices_details 
add constraint UNIQUE_devices_details_device_id
unique(device_id);

-- UNIQUE IMSI
alter table devices_details 
add constraint UNIQUE_devices_details_imsi
unique(imsi);

-- UNIQUE msisdn
alter table devices_details 
add constraint UNIQUE_devices_details_msisdn
unique(msisdn);

-- UNIQUE device_mac
alter table devices_details 
add constraint UNIQUE_devices_details_device_mac
unique(device_mac);

-- UNIQUE imei
alter table devices_details 
add constraint UNIQUE_devices_details_imei
unique(imei);

-- FK id_device
alter table devices_details
add constraint FK_devices_details_device_id
foreign key(device_id)
references devices(id)
on update cascade on delete cascade;

-- CHECK UPDATE_DATE
alter table devices
add constraint CHECK_rate_plans_update_date
check (update_date >= creation_date);

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_audit_history ===========

-- https://developer.cisco.com/docs/control-center/#!get-device-audit-history/get-device-audit-history
create table devices_audit_history(
	
id bigint auto_increment primary key,
device_details_id bigint not null,
description varchar(255),-- The audit will be carried out to verify the configured software
status enum('PENDING'
, 'AUDITED'
, 'CACELLED'
, 'FOR_REVISION') default 'PENDING',
notification_date datetime not null,
audit_date datetime not null,
creation_date datetime not null,
update_date datetime not null

);

-- ======= Restricciones Tabla devices_audit_history ===========

-- UNIQUE ID
alter table devices_audit_history 
add constraint UNIQUE_devices_audit_history_id
unique(id);

-- FK device_details_id
alter table devices_audit_history 
add constraint FK_devices_audit_history_device_details_id
foreign key(device_details_id)
references devices_details(id)
on update cascade on delete cascade;

-- CHECK AUDIT_DATE
alter table devices_audit_history
add constraint CHECK_devices_audit_history_audit_date
check (audit_date >= notification_date);

-- CHECK UPDATE_DATE
alter table devices_audit_history
add constraint CHECK_devices_audit_history_update_date
check (update_date >= creation_date);

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_usage ===========

-- https://developer.cisco.com/docs/control-center/#!get-device-usage/response-example


CREATE TABLE devices_usage(

id bigint auto_increment PRIMARY KEY,
device_details_id bigint not null,
ctd_data_usage int DEFAULT 0,
ctd_sms_usage int DEFAULT 0,
ctd_voice_usage int DEFAULT 0,
ctd_session_count int DEFAULT 0,
overage_limit_reached enum('TRUE','FALSE') DEFAULT 'FALSE',
overage_limit_override enum('DEFAULT','TEMPORARY_OVERRIDE'
,'PERMANENT_OVERRIDE') DEFAULT 'DEFAULT',
creation_date datetime not null,
update_date datetime not null

);

-- ======= Restricciones Tabla device_usage ===========

-- UNIQUE ID
alter table devices_usage 
add constraint UNIQUE_device_usage_id
unique(id);

-- FK device_details_id
alter table devices_usage 
add constraint FK_device_usage_device_details_id
foreign key(device_details_id)
references devices_details(id)
on update cascade on delete cascade;


-- CHECK ctf fieds
ALTER TABLE devices_usage
ADD CONSTRAINT CHECK_devices_usage_ctd
CHECK (ctd_data_usage >= 0 AND ctd_sms_usage >= 0 
AND ctd_voice_usage >= 0 AND ctd_session_count >= 0);


-- CHECK UPDATE_DATE
alter table devices_usage
add constraint CHECK_devices_usage_update_date
check (update_date >= creation_date);



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_cycle_usage_by_zone ===========

-- https://developer.cisco.com/docs/control-center/#!get-device-usage-by-zone


CREATE TABLE devices_cycle_usage_by_zone(

id bigint auto_increment PRIMARY KEY,
device_details_id bigint not null,
device_usage_id bigint not null,
zone_cycle varchar(255) not null,
data_usage varchar(255) not null,
data_usage_unit varchar(255) not null,
voice_mtu_usage varchar(255) not null,
voice_mtu_usage_unit varchar(255) not null,
voice_mou_usage varchar(255) not null,
voice_mou_usage_unit varchar(255) not null,
sms_mtu_usage varchar(255) not null,
sms_mou_usage varchar(255) not null,
creation_date datetime not null,
update_date datetime not null

);

-- ======= Restricciones Tabla devices_cycle_usage_by_zone ===========

-- UNIQUE ID
alter table devices_cycle_usage_by_zone 
add constraint UNIQUE_devices_cycle_usage_by_zone_id
unique(id);

-- FK devices_details_id
alter table devices_cycle_usage_by_zone 
add constraint FK_devices_cycle_usage_by_zone_device_details_id
foreign key(device_details_id)
references devices_details(id)
on update cascade on delete cascade;

-- FK devices_details_id
alter table devices_cycle_usage_by_zone 
add constraint FK_devices_cycle_usage_by_zone_device_usage_id
foreign key(device_details_id)
references devices_usage(id)
on update cascade on delete cascade;


-- CHECK UPDATE_DATE
alter table devices_cycle_usage_by_zone
add constraint CHECK_devices_cycle_usage_by_zone_update_date
check (update_date >= creation_date);

