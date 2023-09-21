/* -------------------------------------
 * ------ MICRODB CISCO DEVICES---------
 * -------------------------------------
 * 
 * 
 * ========= DML UPDATES =============
 */

-- DATABASE
use microdb_cisco_devices;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla rate_plans ===========
select * from rate_plans;
describe rate_plans ;


-- Change name and descriptions for type plan name
update rate_plans set name = 'QERT-789-A'
, description = 'plan A for individual monthly subscriptions'
where id = 1 and name = 'QERT-789';

update rate_plans set name = 'QERT-789-B'
, description = 'plan B for individual annual subscriptions'
where id = 2 and name = 'QERT-790';


-- Change version_id and version_plan 
update rate_plans set version_id = '777278'
, version_plan = '2.7.1'
where version_id = '777212';

update rate_plans set version_id = '7772709'
, version_plan = '1.4.6'
where version_id = '777213';


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= Tabla devices_details ===========

select * from devices_details;
describe devices_details ;

