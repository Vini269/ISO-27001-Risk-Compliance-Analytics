INSERT INTO audit_findings
(
    audit_id,
    asset_id,
    control_id,
    finding_title,
    finding_description,
    severity,
    finding_status,
    remediation_plan,
    target_date,
    resolved_date
)
VALUES
(
    1,
    3,
    1,
    'Weak Access Control',
    'Employee database access is not adequately restricted.',
    'High',
    'Open',
    'Review user access permissions and implement least privilege.',
    '2026-09-15',
    NULL
),
(
    1,
    4,
    2,
    'Missing Security Policy',
    'Website security policy is not properly documented.',
    'Medium',
    'In Progress',
    'Update and formally document the website security policy.',
    '2026-09-30',
    NULL
),
(
    2,
    6,
    3,
    'Segregation of Duties Gap',
    'Payroll system has insufficient separation of responsibilities.',
    'High',
    'Open',
    'Separate payroll approval and processing responsibilities.',
    '2026-09-20',
    NULL
),
(
    3,
    5,
    7,
    'Firewall Configuration Issue',
    'Firewall configuration does not fully comply with security requirements.',
    'Critical',
    'Open',
    'Review firewall rules and remove unnecessary access.',
    '2026-09-10',
    NULL
),
(
    4,
    2,
    4,
    'Server Security Weakness',
    'Finance server requires additional security hardening.',
    'High',
    'In Progress',
    'Apply security patches and hardening recommendations.',
    '2026-09-25',
    NULL
),
(
    5,
    8,
    6,
    'Router Access Issue',
    'WiFi router administrative access is not sufficiently secured.',
    'Medium',
    'Resolved',
    'Enforce strong administrative credentials and access restrictions.',
    '2026-08-10',
    '2026-08-05'
),
(
    6,
    9,
    9,
    'Backup Security Finding',
    'Backup server access controls require improvement.',
    'Medium',
    'Open',
    'Restrict backup server access and review permissions.',
    '2026-10-01',
    NULL
);

select * from audit_findings;

(5, 6, 7,
 'Infrastructure vulnerability scanning is not being performed at the required frequency.',
 'Critical',
 'In Progress',
 'Implement scheduled vulnerability scans and track remediation activities.',
 '2026-08-20',
 NULL),

(6, 9, 10,
 'Third-party security assessment evidence is missing for the backup infrastructure provider.',
 'High',
 'Open',
 'Obtain the required security assessment documentation from the service provider.',
 '2026-08-25',
 NULL);
 
 update audit_findings
 set finding_description = 'Backup server access controls require improvement.'
 where finding_id = 7;
 
