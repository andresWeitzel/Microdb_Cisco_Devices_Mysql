/* -------------------------------------
 * ------ MICRODB CISCO DEVICES---------
 * -------------------------------------
 * 
 * 
 * ========= DML UPDATES =============
 */

-- DATABASE
use microdb_cisco_devices;

-- VARS
SET @created_at = now();
SET @updated_at = now();
set @today = now();


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla rate_plans ===========
select * from rate_plans;
describe rate_plans ;


-- Change name and descriptions for type plan name
update rate_plans set name = 'QERT-789-A'
, description = 'plan A for individual monthly subscriptions'
, update_date = @updated_at
where id = 1 and name = 'QERT-789';

update rate_plans set name = 'QERT-789-B'
, description = 'plan B for individual annual subscriptions'
, update_date = @updated_at
where id = 2 and name = 'QERT-790';


-- Change version_id and version_plan 
update rate_plans set version_id = '777278'
, version_plan = '2.7.1'
, update_date = @updated_at
where version_id = '777212';

update rate_plans set version_id = '7772709'
, version_plan = '1.4.6'
, update_date = @updated_at
where version_id = '777213';

-- Change type_plan, subs_charge and tiers
update rate_plans set type_plan = 'Monthly - Individual Subscriber Plan'
, subscription_charge = 2.88
, number_of_tiers = 1
, update_date = @updated_at
where name = 'QERT-789-A';

select * from rate_plans;
describe rate_plans ;

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices ===========

select * from devices;
describe devices;


-- Update all fields
update devices set iccid= '8988216716970004972'
, status = 'ACTIVATION_READY'
, rate_plan_id = 4
, creation_date = @created_at
, update_date = @updated_at
where id=1;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_details ===========

select * from devices_details;
describe devices_details ;

-- Update three first fields
update devices_details as dev_det 
inner join devices as dev
on dev_det.device_id = dev.id
set imsi = '901161697004977'
, msisdn = '778239013883123'
, imei = '662712771627362'
, dev_det .update_date = @updated_at
where dev.id = 1;

-- Update the rest of the fields
update devices_details as dev_det 
inner join devices as dev
on dev_det.device_id = dev.id
set dev_det.date_activated = @created_at
, dev_det.date_added = @created_at
, dev_det.date_updated = @created_at
, dev_det.fixed_ip_adress = '192.168.1.188'
, dev_det.fixed_ipv6_adress = '9832:9010:4347:c500:4542:b4ac:ca9c:9lo'
, dev_det.sim_notes = 'The device is activated, ready for its initial configuration and complete hardware upgrade'
, dev_det.device_mac = '00-B0-D0-63-C2-33'
, dev_det.creation_date = @created_at
, dev_det.update_date = @updated_at
where dev_det.id = 2;


-- Update the ip's fields according to de imei
update devices_details as dev_det 
inner join devices as dev
on dev_det.device_id = dev.id
set dev_det.fixed_ip_adress = '172.16.1.125'
, dev_det.fixed_ipv6_adress = '3322:1234:2213:a60w:9029:b4sc:cd9c:o9a'
, dev_det.update_date = @updated_at
where dev_det.imei = '826615223131233';

-- Update the ip's fields and sim_notes according to the device_mac
update devices_details as dev_det 
inner join devices as dev
on dev_det.device_id = dev.id
set dev_det.fixed_ip_adress = '192.168.1.10'
, dev_det.fixed_ipv6_adress = '8931:9041:4337:c602:4533:b123D:cd9c:898'
, dev_det.sim_notes = 'The device is activated, ready for its initial configuration. ips are updated'
, dev_det.update_date = @updated_at
where dev_det.device_mac = '00-A0-K9-72-G3-21';


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_audit_history ===========

select * from devices_audit_history;
describe devices_audit_history ;


-- update all fields according to the device_details_id
update devices_audit_history as dev_aud_his
inner join devices_details as dev_det
on dev_det.id = dev_aud_his.device_details_id
set dev_aud_his.description  = 'The audit has been carried out successfully'
, dev_aud_his.status = 'AUDITED'
, dev_aud_his.notification_date = @today
, dev_aud_his.audit_date = @today
, dev_aud_his.creation_date = @created_at
, dev_aud_his.update_date = @updated_at
where dev_aud_his.device_details_id  = 1;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_usage ===========

select * from devices_usage;
describe devices_usage ;

-- update ctd fields according to the device_details_id
update devices_usage as dev_us
inner join devices_details as dev_det
on dev_det.id = dev_us.device_details_id
set dev_us.ctd_data_usage = ctd_data_usage + 550
, dev_us.ctd_sms_usage = ctd_sms_usage + 50
, dev_us.ctd_voice_usage = ctd_voice_usage + 1200
, dev_us.ctd_session_count = ctd_session_count + 23
, dev_us.update_date = @updated_at
where dev_us.device_details_id  = 1;


-- update overage fields according to the id
update devices_usage as dev_us
inner join devices_details as dev_det
on dev_det.id = dev_us.device_details_id
set dev_us.overage_limit_reached = 'TRUE'
, dev_us.overage_limit_override = 'PERMANENT_OVERRIDE'
, dev_us.update_date = @updated_at
where dev_us.id = 5;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_cycle_usage_by_zone ===========


select * from devices_cycle_usage_by_zone;
select * from devices_details;
select * from devices_usage;

-- update the zone_cycle according to the device_details_id
update devices_cycle_usage_by_zone as dev_cy_us_by_zone
inner join devices_details as dev_det
on dev_det.id = dev_cy_us_by_zone.device_details_id
set dev_cy_us_by_zone.zone_cycle  = 'local_zone'
, dev_cy_us_by_zone.update_date = @updated_at
where dev_cy_us_by_zone.device_details_id  = 1;

-- update the data according to the device_usage_id
update devices_cycle_usage_by_zone as dev_cy_us_by_zone
inner join devices_usage as dev_us
on dev_us.id = dev_cy_us_by_zone.device_usage_id
set dev_cy_us_by_zone.data_usage = data_usage + 200
, dev_cy_us_by_zone.data_usage_unit = data_usage_unit + 220
, dev_cy_us_by_zone.update_date = @updated_at
where dev_cy_us_by_zone.device_details_id  = 2;


-- update the voice according to the id
update devices_cycle_usage_by_zone as dev_cy_us_by_zone
inner join devices_details as dev_det
on dev_det.id = dev_cy_us_by_zone.device_details_id
inner join devices_usage as dev_us
on dev_us.id = dev_cy_us_by_zone.device_usage_id
set dev_cy_us_by_zone.voice_mtu_usage = voice_mtu_usage + 420
, dev_cy_us_by_zone.voice_mtu_usage_unit = voice_mtu_usage_unit + 510
, dev_cy_us_by_zone.voice_mou_usage  = voice_mou_usage  + 1702
, dev_cy_us_by_zone.update_date = @updated_at
where dev_cy_us_by_zone.id  = 3;

