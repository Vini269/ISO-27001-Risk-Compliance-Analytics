CREATE TABLE audits (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    audit_name VARCHAR(100) NOT NULL,
    audit_type VARCHAR(50) NOT NULL,
    audit_date DATE NOT NULL,
    auditor VARCHAR(100) NOT NULL,
    audit_status VARCHAR(30) NOT NULL
);