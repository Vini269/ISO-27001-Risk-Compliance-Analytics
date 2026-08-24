create table asset_control
(
	asset_control_id int auto_increment primary key,
    asset_id int not null,
    control_id int not null,
    implementation_date date,
    compliance_status varchar(30),
    
    foreign key (asset_id) references assets(asset_id),
    foreign key (control_id) references controls(control_id)
);

/*Added implementation status*/
alter table asset_control
add column implementation_status varchar(50);

/*Added last reviewed date*/
alter table asset_control
add column last_reviewed_date date;

/*refactored implementation status*/
update asset_control ac
join controls c
on ac. control_id = c. control_id
set ac.implementation_status = c.implementation_status;

/*Tested our new column*/
SELECT
    ac.asset_control_id,
    c.control_name,
    ac.implementation_status
FROM asset_control ac
JOIN controls c
ON ac.control_id = c.control_id;

select * from asset_control;



UPDATE asset_control
SET last_reviewed_date = '2026-07-15'
WHERE asset_control_id = 1;

UPDATE asset_control
SET last_reviewed_date = '2026-07-18'
WHERE asset_control_id = 2;

UPDATE asset_control
SET last_reviewed_date = '2026-07-20'
WHERE asset_control_id = 3;

UPDATE asset_control
SET last_reviewed_date = '2026-07-22'
WHERE asset_control_id = 4;

UPDATE asset_control
SET last_reviewed_date = '2026-07-25'
WHERE asset_control_id = 5;

UPDATE asset_control
SET last_reviewed_date = '2026-07-28'
WHERE asset_control_id = 6;

UPDATE asset_control
SET last_reviewed_date = '2026-07-30'
WHERE asset_control_id = 7;

UPDATE asset_control
SET last_reviewed_date = '2026-07-31'
WHERE asset_control_id = 8;

UPDATE asset_control
SET last_reviewed_date = '2026-08-01'
WHERE asset_control_id = 9;

UPDATE asset_control
SET last_reviewed_date = '2026-08-02'
WHERE asset_control_id = 10;