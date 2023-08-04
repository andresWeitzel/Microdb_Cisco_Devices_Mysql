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
delete from communication_plans;
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
,'1.2','Active','Monthly - Individual Subscriber',2.1, 0, @created_at
, @updated_at),
('QERT-790','plan for individual annual subscriptions',892222,'1.1'
,'Published','Annually - Individual Subscriber', 1.99, 1, @created_at
, @updated_at),
('FTY-189','plan for annual subscriptions up to 3 people',777212,'2.7','Active'
,'Annually - Until 3 Subscribers'
, 3.89, 2, @created_at, @updated_at);
