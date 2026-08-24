INSERT INTO risk_register
(asset_id, risk_name, risk_description, likelihood, impact, risk_score, risk_level, risk_owner, mitigation_plan, risk_status, identified_date, target_closure_date)
VALUES

(3,'Data Breach',
'Unauthorized access to employee database.',
5,5,25,'Critical','Rahul',
'Enable encryption, MFA and database monitoring.',
'Open','2026-08-01','2026-09-01'),

(2,'Ransomware Attack',
'Finance server may be encrypted by ransomware.',
4,5,20,'Critical','Amit',
'Daily backups and endpoint protection.',
'In Progress','2026-08-02','2026-09-10'),

(4,'SQL Injection',
'Company website is vulnerable to SQL Injection.',
4,4,16,'High','Rahul',
'Use parameterized queries and WAF.',
'Open','2026-08-03','2026-08-25'),

(1,'Laptop Theft',
'HR laptop may be stolen causing data exposure.',
3,3,9,'Medium','Neha',
'Enable BitLocker and device tracking.',
'Open','2026-08-01','2026-08-20'),

(5,'Firewall Misconfiguration',
'Incorrect firewall rules may expose internal network.',
3,5,15,'High','Anjali',
'Review firewall rules monthly.',
'In Progress','2026-08-04','2026-08-28'),

(3,'Weak Password Policy',
'Weak passwords increase unauthorized access risk.',
4,4,16,'High','Rahul',
'Enforce strong password policy and MFA.',
'Open','2026-08-05','2026-08-30'),

(2,'Backup Failure',
'Backups are not being verified regularly.',
2,5,10,'Medium','Amit',
'Automate backup verification.',
'Open','2026-08-06','2026-08-31'),

(4,'Cross-Site Scripting (XSS)',
'Website vulnerable to stored XSS.',
3,4,12,'Medium','Rahul',
'Implement input validation and output encoding.',
'Closed','2026-07-20','2026-08-05'),

(5,'DDoS Attack',
'Public services may become unavailable.',
4,4,16,'High','Anjali',
'Deploy DDoS protection and rate limiting.',
'Open','2026-08-07','2026-09-05'),

(3,'Insider Threat',
'Privileged employee may misuse sensitive information.',
2,5,10,'Medium','Rahul',
'Apply least privilege and audit logging.',
'In Progress','2026-08-08','2026-09-15');

select * from risk_register;