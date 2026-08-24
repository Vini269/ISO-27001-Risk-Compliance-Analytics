create table assets(
asset_id int auto_increment primary key,
asset_name varchar(100) not null,
asset_type varchar(20) not null ,
asset_owner varchar(20),
department varchar(20),
criticality varchar(50) not null ,
asset_status varchar(50),
purchase_date date
);

/*Added department id*/
ALTER TABLE assets
ADD COLUMN department_id INT;

/*refactored department id*/
update assets a 
join departments d
on a.department = d.department_name
set a.department_id = d.department_id;

/*Created department id as foreign key*/
alter table assets
add constraint fk_assets_department foreign key (department_id) references departments(department_id);

/*Deleted department table*/
alter table assets
drop column department;

/*Tested our new column */
select a.asset_name, d.department_name
from assets a
join departments d
on a.department_id = d.department_id;
