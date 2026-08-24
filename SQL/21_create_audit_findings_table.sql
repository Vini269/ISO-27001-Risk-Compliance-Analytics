CREATE TABLE audit_findings (
    finding_id INT PRIMARY KEY AUTO_INCREMENT,
    audit_id INT NOT NULL,
    asset_id INT,
    control_id INT,
    finding_title VARCHAR(255) NOT NULL,
    finding_description TEXT,
    severity VARCHAR(20) NOT NULL,
    finding_status VARCHAR(30) NOT NULL,
    remediation_plan TEXT,
    target_date DATE,
    resolved_date DATE,

    FOREIGN KEY (audit_id)
        REFERENCES audits(audit_id),

    FOREIGN KEY (asset_id)
        REFERENCES assets(asset_id),

    FOREIGN KEY (control_id)
        REFERENCES controls(control_id)
);