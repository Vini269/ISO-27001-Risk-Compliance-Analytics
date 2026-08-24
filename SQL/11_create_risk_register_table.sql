create table risk_register
(
	risk_id int auto_increment primary key,
    asset_id int not null,
    risk_name varchar(50) not null,
    risk_description text,
    likelihood int not null,
    imapct int not null,
    risk_score int not null,
    risk_level varchar(20) not null,
    risk_owner varchar(100),
    mitigation_plan text,
    risk_status varchar(30) not null,
    identified_date date,
    target_closure_date date,
    
    constraint fk_risk_asset foreign key (asset_id) references assets(asset_id)
);

ALTER TABLE risk_register
ADD CONSTRAINT chk_likelihood
CHECK (likelihood BETWEEN 1 AND 5);

ALTER TABLE risk_register
ADD CONSTRAINT chk_impact
CHECK (impact BETWEEN 1 AND 5);

ALTER TABLE risk_register
ADD CONSTRAINT chk_risk_score
CHECK (risk_score BETWEEN 1 AND 25);

ALTER TABLE risk_register
ADD CONSTRAINT chk_risk_level
CHECK (risk_level IN ('Low','Medium','High','Critical'));

ALTER TABLE risk_register
ADD CONSTRAINT chk_risk_status
CHECK (risk_status IN ('Open','In Progress','Closed'));

ALTER TABLE risk_register
ADD COLUMN risk_review_date DATE;
UPDATE risk_register
SET risk_review_date = '2026-08-01'
WHERE risk_review_date IS NULL;








 



