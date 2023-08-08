/* -------------------------------------
 * ------ MICRODB CISCO DEVICES---------
 * -------------------------------------
 * 
 * 
 * ========= DML INSERTS =============
 */

-- DATABASE
use microdb_cisco_devices;

-- TABLES
delete from rate_plans;
delete from devices;
delete from devices_details;
/*
delete from device_audit_history;
delete from device_usage;
delete from device_usage_by_zone;
*/

-- VARS
SET @created_at = now();
SET @updated_at = now();

-- https://developer.cisco.com/docs/control-center/#!get-rate-plans/request-example
insert into rate_plans (name, description, version_id
, version_plan, status, type_plan, subscription_charge
, number_of_tiers, creation_date, update_date) values 
('QERT-789','plan for individual monthly subscriptions',892221
,'1.2','Active','Monthly - Individual Subscriber',2.7, 0, @created_at
, @updated_at),
('QERT-790','plan for individual annual subscriptions',892222,'1.1'
,'Published','Annually - Individual Subscriber', 1.50, 1, @created_at
, @updated_at),
('FTY-189','plan for annual subscriptions up to 3 people',777212,'2.7','Active'
,'Annually - Until 3 Subscribers'
, 3.04, 2, @created_at, @updated_at),
('FTY-190','plan for annual subscriptions up to 5 people',777213,'2.8','Published'
,'Annually - Until 5 Subscribers'
, 3.50, 3, @created_at, @updated_at),
('OPQ-23','plan every three months, individual',234899,'1.3','Published'
,'Individual quarterly plan', 2.1, 1, @created_at, @updated_at),
('IOU-89','plan every three months, up to 5 people',777892,'2.5','Active'
,'quarterly plan, up to 5 people', 3.89, 3, @created_at, @updated_at),
('IOU-90','plan every three months, up to 7 people',777213,'2.6','Inactive'
,'quarterly plan, up to 7 people', 3.99, 4, @created_at, @updated_at);
