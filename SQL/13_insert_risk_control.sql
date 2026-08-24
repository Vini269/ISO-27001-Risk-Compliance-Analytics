INSERT INTO risk_control
(risk_id, control_id, control_effectiveness, implementation_priority, remarks, last_reviewed_date)

VALUES

(1,1,'Effective','High',
'Security policy implemented and reviewed.',
'2026-07-20'),

(1,7,'Partially Effective','High',
'Asset inventory needs improvement.',
'2026-07-22'),

(2,1,'Effective','High',
'Backup policy implemented successfully.',
'2026-07-18'),

(2,6,'Partially Effective','High',
'Threat intelligence feeds require regular updates.',
'2026-07-25'),

(3,9,'Effective','High',
'Secure coding practices implemented.',
'2026-07-28'),

(3,8,'Partially Effective','High',
'Project security review pending.',
'2026-07-29'),

(4,7,'Effective','Medium',
'Asset inventory maintained properly.',
'2026-07-30'),

(5,6,'Partially Effective','High',
'Threat intelligence not updated regularly.',
'2026-07-27'),

(6,2,'Effective','High',
'Security roles clearly defined.',
'2026-07-26'),

(6,3,'Effective','Medium',
'Segregation of duties implemented.',
'2026-07-24'),

(7,1,'Effective','High',
'Backup procedures tested successfully.',
'2026-07-23'),

(8,9,'Partially Effective','High',
'Input validation needs improvement.',
'2026-07-21'),

(9,6,'Ineffective','High',
'DDoS monitoring not configured properly.',
'2026-07-20'),

(10,2,'Partially Effective','High',
'Privileged access reviews are overdue.',
'2026-07-19');

select * from risk_control;


