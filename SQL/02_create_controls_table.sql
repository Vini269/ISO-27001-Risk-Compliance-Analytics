create table controls
(
	control_id int auto_increment primary key,
    control_code varchar(20) not null,
    clause varchar(20),
    control_name varchar(255) not null,
    department varchar(100),
    owner_c varchar(100),
    implementation_status varchar(30),
    priority varchar(20),
    review_date date,
    last_updated date
);

/*Added department id column*/
alter table controls
add column department_id int;

/*Refactored department id*/
update controls c
join departments d
on c.department = d.department_name
set c.department_id = d.department_id;


/*Make department id as foreign key*/
alter table controls
add constraint fk_controls_department
foreign key(department_id)
references departments(department_id);

/*Deleted department column*/
alter table controls
drop column department;

/*Removing duplicacy*/
alter table controls
drop column implementation_status;


