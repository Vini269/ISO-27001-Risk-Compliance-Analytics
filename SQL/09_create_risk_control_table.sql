create table risk_control
(
risk_control_id INT AUTO_INCREMENT PRIMARY KEY,

risk_id INT NOT NULL,

control_id INT NOT NULL,

control_effectiveness VARCHAR(30),

implementation_priority VARCHAR(20),

remarks TEXT,

last_reviewed_date DATE,

constraint fk_risk_control foreign key (risk_id) references risk_register(risk_id),
constraint fk_control_risk foreign key (control_id) references controls(control_id),

unique(risk_id, control_id)

);