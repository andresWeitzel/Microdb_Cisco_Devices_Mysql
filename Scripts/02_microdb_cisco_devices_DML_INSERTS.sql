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
DELETE FROM devices_cycle_usage_by_zone;
DELETE FROM devices_usage;
delete from devices_audit_history;
delete from devices_details;
delete from devices;
delete from rate_plans;


-- AUTO_INCREMENT
alter table devices_cycle_usage_by_zone auto_increment 1;
alter table devices_usage auto_increment 1;
alter table devices_audit_history auto_increment 1;
alter table devices_details auto_increment 1;
alter table devices auto_increment 1;
alter table rate_plans auto_increment 1;


-- VARS
SET @created_at = now();
SET @updated_at = now();
set @today = now();
set @audit_at = now() + interval 3 month;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla rate_plans ===========

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
('IOU-90','plan every three months, up to 7 people',777245,'2.6','Inactive'
,'quarterly plan, up to 7 people', 3.99, 4, @created_at, @updated_at);

select * from rate_plans;

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices ===========

insert into devices (iccid, status, rate_plan_id, creation_date, update_date) values
('8988216716970004971', 'ACTIVATED', 1, @created_at, @updated_at ),
('8830239482934882348', 'ACTIVATION_READY', 2, @created_at, @updated_at ),
('9928127278173287123', 'ACTIVATED', 3 , @created_at, @updated_at),
('2553623889812221298', 'REPLACED', 4 , @created_at, @updated_at),
('9928127278173283099', 'TEST_READY', 5 , @created_at, @updated_at),
('1298312381731727313', 'ACTIVATED', 6 , @created_at, @updated_at),
('5637705540155723682', 'DESACTIVATED', 6 , @created_at, @updated_at),
('8812931231231244444', 'ACTIVATION_READY', 3 , @created_at, @updated_at),
('9021929831321982981', 'INVENTORY', 2 , @created_at, @updated_at),
('5553476230102909312', 'RETIRED', 1 , @created_at, @updated_at);


select * from devices;


insert into devices_details(device_id, imsi, msisdn, imei, date_activated
, date_added, date_updated, fixed_ip_adress, fixed_ipv6_adress, sim_notes
, device_mac, creation_date, update_date) values
(1, '901161697004975', '778239013883123', '662712771627361', @today
, @created_at, @updated_at, '192.168.1.0', '9832:9010:4347:c500:4542:b4ac:ca9c:8bt'
, 'The device is activated, ready for its initial configuration', '00-B0-D0-63-C2-26'
, @created_at, @updated_at),
(2, '882193232829129', '222771273733128', '209291923231233', @today
, @created_at, @updated_at, '192.168.0.1', '8291:9041:4337:c601:4542:b4sc:cd9c:8jt'
, 'The device is activated, ready for its initial configuration', '00-A0-KK-72-A2-02'
, @created_at, @updated_at),
(3, '992128882819291', '666251227162766', '129928128821982', @today
, @created_at, @updated_at, '172.20.10.0', '9212:1192:2213:a60w:9029:b4sc:cd9c:4fg'
, 'The device is activated, ready for its initial configuration', '00-LO-D1-72-A2-23'
, @created_at, @updated_at),
(4, '127327271198812', '127883712631312', '826615223131233', @today
, @created_at, @updated_at, '172.16.0.0', '3322:1234:2213:a60w:9029:b4sc:cd9c:9hj'
, 'The device was replaced as a malfunction is reported', '00-A1-D0-11-G2-33'
, @created_at, @updated_at),
(5, '772819992123331', '998212123000122', '445323466565333', @today
, @created_at, @updated_at, '192.168.1.0', '0092:3232:1123:G90w:0921:JSU7A:ca9c:6jj'
, 'the device has been successfully tested, it is waiting for an initial configuration'
, '19-B2-R6-89-J2-22', @created_at, @updated_at),
(6, '982123333212882', '118292838001233', '409019293012932', @today
, @created_at, @updated_at, '10.0.0.0', '8271:2212:3312:LOP2:9383:ASU1A:FG9c:990'
, 'The device is activated, ready for its initial configuration'
, '19-B1-R5-88-J1-21', @created_at, @updated_at),
(7, '102033100923231', '009301092111233', '415522666162222', @today
, @created_at, @updated_at, '172.16.3.0', '8272:2342:3322:klP2:2213:Adf1A:FG9c:llo'
, 'The device has been deactivated, the end user does not maintain the current service'
, '21-K0-LO-12-LL-09', @created_at, @updated_at),
(8, '2221932332829121', '928771292733121', '7282919232310021', @today
, @created_at, @updated_at, '192.168.1.0', '2223:9041:4337:c602:4533:b123D:cd9c:898'
, 'The device is activated, ready for its initial configuration', '00-A0-K9-72-G3-21'
, @created_at, @updated_at),
(9, '7645503404362337', '990281655252551', '0912323123123123', @today
, @created_at, @updated_at, '10.0.1.0', '9102:1192:6728:JK92:4533:b123D:cd9c:KL2'
, 'Device remains for inventory, missing hardware checks and software configuration'
, '98-G0-K9-11-G3-09', @created_at, @updated_at),
(10, '190238721837123', '123123999923112', '72777712312333', @today
, @created_at, @updated_at, '192.168.1.0', '2213:3192:9902:JS92:4223:b0PD:c23c:pL1'
, 'The device has been removed and is out of service due to a connection board failure'
, 'P9-12-AR-09-G3-56', @created_at, @updated_at);

select * from devices_details;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_audit_history ===========

insert into devices_audit_history (devices_details_id, description, status 
, notification_date, audit_date, creation_date, update_date ) values
(1, 'The audit will be carried out to verify the configured software', 
'PENDING', @today, @audit_at, @created_at, @updated_at),
(2, 'The audit will be carried out to verify the operation of the hardware', 
'PENDING', @today, @audit_at, @created_at, @updated_at),
(3, 'The audit will be carried out to verify the configured software', 
'FOR_REVISION', @today, @audit_at, @created_at, @updated_at),
(4, 'Software updates will be released', 
'PENDING', @today, @audit_at, @created_at, @updated_at),
(5, 'The audit will be carried out to verify the configured software', 
'PENDING', @today, @audit_at, @created_at, @updated_at),
(6, 'The audit will be carried out to verify the operation of the hardware', 
'FOR_REVISION', @today, @audit_at, @created_at, @updated_at),
(7, 'The audit will be carried out to verify the configured software', 
'PENDING', @today, @audit_at, @created_at, @updated_at),
(8, 'The audit will be carried out to verify the configured software', 
'FOR_REVISION', @today, @audit_at, @created_at, @updated_at),
(9, 'The new improvement implemented will be analyzed', 
'PENDING', @today, @audit_at, @created_at, @updated_at),
(10, 'The new installed version will be analyzed', 
'PENDING', @today, @audit_at, @created_at, @updated_at);

select * from devices_audit_history;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_usage ===========

INSERT INTO devices_usage ( devices_details_id, ctd_data_usage, ctd_sms_usage
, ctd_voice_usage, ctd_session_count, overage_limit_reached, overage_limit_override
, creation_date , update_date ) VALUES
(1, 1034, 200, 4000, 10, 'FALSE', 'DEFAULT', @created_at, @updated_at),
(2, 6078, 456, 6000, 34, 'TRUE','TEMPORARY_OVERRIDE', @created_at, @updated_at),
(3, 30098, 1056, 40000, 104, 'TRUE','PERMANENT_OVERRIDE', @created_at, @updated_at),
(4, 46990, 2768, 58900, 209, 'TRUE','PERMANENT_OVERRIDE', @created_at, @updated_at),
(5, 2074, 160, 5060, 45, 'FALSE', 'DEFAULT', @created_at, @updated_at),
(6, 7044, 250, 8092, 58, 'FALSE', 'DEFAULT', @created_at, @updated_at),
(7, 1034, 255, 1020, 79, 'TRUE','TEMPORARY_OVERRIDE', @created_at, @updated_at),
(8, 9872, 872, 2220, 108, 'TRUE','TEMPORARY_OVERRIDE', @created_at, @updated_at),
(9, 2245, 347, 1098, 65, 'TRUE','PERMANENT_OVERRIDE', @created_at, @updated_at),
(6, 5567, 187, 6712, 46, 'FALSE', 'DEFAULT', @created_at, @updated_at),
(7, 7845, 267, 1089, 78, 'TRUE', 'PERMANENT_OVERRIDE', @created_at, @updated_at),
(8, 56789, 3456, 67839, 290, 'FALSE', 'DEFAULT', @created_at, @updated_at),
(9, 3678, 151, 887, 59, 'TRUE','TEMPORARY_OVERRIDE', @created_at, @updated_at),
(10, 7763, 229, 1029, 41, 'TRUE','TEMPORARY_OVERRIDE', @created_at, @updated_at);



select * from devices_usage;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_cycle_usage_by_zone ===========

insert into devices_cycle_usage_by_zone ( device_details_id , device_usage_id ,zone_cycle,
data_usage, data_usage_unit, voice_mtu_usage, voice_mtu_usage_unit,
voice_mou_usage, voice_mou_usage_unit, sms_mtu_usage, sms_mou_usage
, creation_date, update_date ) values
(1 , 1 , "default_zone", "4000", "4000", "14400", "14400", "18000"
, "18000", "256", "567", @created_at, @updated_at),
(2 , 2,   "default_zone", "6700", "6700", "18922", "18922", "21000"
, "21000", "458", "876", @created_at, @updated_at),
(3 , 3 , "local_zone", "2340", "2340", "5567", "5567", "7012"
, "7012", "667", "889", @created_at, @updated_at),
(4 , 4 , "local_zone", "1340", "3340", "6567", "7567", "9012"
, "9012", "367", "489", @created_at, @updated_at),
(5 , 5 , "default_zone", "4020", "4020", "14600", "14600", "21000"
, "21000", "216", "547", @created_at, @updated_at),
(6 , 6, "default_zone", "748", "748", "1230", "1230", "2234"
, "2234", "112", "130", @created_at, @updated_at);



select * from devices_cycle_usage_by_zone;
