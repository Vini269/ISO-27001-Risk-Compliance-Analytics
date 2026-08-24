CREATE TABLE risk_assessment_history (
    assessment_id INT PRIMARY KEY AUTO_INCREMENT,
    risk_id INT NOT NULL,
    risk_score INT NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    assessment_date DATE NOT NULL,

    FOREIGN KEY (risk_id)
        REFERENCES risk_register(risk_id)
);