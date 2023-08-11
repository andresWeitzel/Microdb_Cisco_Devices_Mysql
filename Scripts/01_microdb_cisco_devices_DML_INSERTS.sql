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
set @today = now();

-- https://developer.cisco.com/docs/control-center/#!get-rate-plans/request-example
-- status enum('Published','Active','Inactive');
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

/*
 * -- https://pubhub.devnetcloud.com/media/control-center-sandbox/docs/Content/api/rest/get_started_rest.htm#api_sim_status
status enum('ACTIVATION_READY'
, 'REPLACED'
, 'ACTIVATED'
, 'DESACTIVATED'
, 'INVENTORY'
, 'PURGED'
, 'RETIRED'
, 'TEST_READY') default 'ACTIVATION_READY',*/
insert into devices (iccid, status, rate_plan_id, creation_date, update_date) values
('8988216716970004971', 'ACTIVATED', 1, @created_at, @updated_at ),
('8830239482934882348', 'ACTIVATION_READY', 2, @created_at, @updated_at ),
('9928127278173287123', 'ACTIVATED', 3 , @created_at, @updated_at),
('2553623889812221298', 'REPLACED', 4 , @created_at, @updated_at),
('9928127278173287123', 'TEST_READY', 5 , @created_at, @updated_at),
('1298312381731727313', 'ACTIVATED', 6 , @created_at, @updated_at),
('5637705540155723682', 'DESACTIVATED', 6 , @created_at, @updated_at),
('8812931231231244444', 'ACTIVATION_READY', 3 , @created_at, @updated_at),
('9021929831321982981', 'INVENTORY', 2 , @created_at, @updated_at),
('5553476230102909312', 'RETIRED', 1 , @created_at, @updated_at);


/*
 *
 * 
insert into devices_details(device_id, imsi, msisdn, imei, date_activated
, date_added, date_updated, fixed_ip_adress, fixed_ipv6_adress, sim_notes
, device_mac, creation_date, update_date) values
(1, '901161697004975', '778239013883123', '662712771627361', @today
, @created_at, @updated_at, '192.168.1.1', '9832:9010:4347:c500:4542:b4ac:ca9c:8bt'
, 'The device is activated, ready for its initial configuration', ),
();
*/

