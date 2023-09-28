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
update devices_details as dev_det inner join devices as dev
on dev_det.device_id = dev.id
set imsi = '901161697004977'
, msisdn = '778239013883123'
, imei = '662712771627362'
, dev_det .update_date = @updated_at
where dev.id = 1;