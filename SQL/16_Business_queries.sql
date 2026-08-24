/**/
select d.department_name, count(a.asset_id) as total_asset
from assets a
join departments d
on a.department_id = d.department_id
group by department_name
;

/**/
select d.department_name, count(a.asset_id) as critical_asset
from assets a 
join departments d
on a.department_id=d.department_id
where criticality in ('Critical', 'High')
group by d.department_name
;

/**/
select asset_name, asset_type, d.department_name
from assets a
left join departments d
on a.department_id = d.department_id
join asset_control ac 
on a.asset_id = ac.asset_id 
where ac.asset_id is null
;

/**/
select asset_name, department_name, risk_name, risk_score, risk_level
from assets a
join departments d
on a.department_id = d.department_id
join risk_register rr
on a.asset_id = rr.asset_id
order by risk_score desc
limit 5
;

/**/
select department_name, round(avg(risk_score),2) Avg_Risk_Score
from departments d
join assets a
on d.department_id = a.department_id
join risk_register rr
on a.asset_id = rr.asset_id
group by department_name
order by Avg_Risk_Score desc
;

/**/
select risk_name, asset_name, risk_level, risk_score
from risk_register rr
left join risk_control rc
on rr.risk_id = rc.risk_id
join assets a
on a.asset_id = rr.asset_id
where rc.risk_id is null
;

/**/
select 
department_name as Department, 
count(ac.control_id) as Total_Controls,
SUM(
    CASE
        WHEN compliance_status = 'Compliant' THEN 1
        ELSE 0
    END
) as Compliant_Controls, 
round(SUM(
    CASE
        WHEN compliance_status = 'Compliant' THEN 1
        ELSE 0
    END
) * 100 / count(control_id),2) as compliance_percentage
from assets a
join asset_control ac
on a.asset_id = ac.asset_id
join departments d
on a.department_id = d.department_id
group by d.department_id, d.department_name
;

/**/
SELECT risk_owner,COUNT(risk_id) AS total_risks
FROM risk_register 
GROUP BY risk_owner
ORDER BY total_risks DESC
LIMIT 5;

/**/
select control_name, review_date ,datediff(current_date(), review_date) as days_since_Review
from controls
where datediff(current_date(), review_date) < 30
;

/**/
SELECT
    d.department_name,
    COUNT(a.asset_id) AS total_assets
FROM departments d
JOIN assets a
ON d.department_id = a.department_id
GROUP BY d.department_name
HAVING COUNT(a.asset_id) > 3;

/**/
create view vw_risk_summary as
SELECT
    a.asset_name,
    rr.risk_name,
    rr.risk_score,
    rr.risk_level,
    d.department_name
FROM risk_register rr
JOIN assets a
ON rr.asset_id = a.asset_id
JOIN departments d
ON a.department_id = d.department_id;

/**/
with department_avg as
(
	select department_name, round(avg(risk_score),2) Avg_Risk_Score
from departments d
join assets a
on d.department_id = a.department_id
join risk_register rr
on a.asset_id = rr.asset_id
group by department_name
)
select * from department_avg
where Avg_Risk_Score > 15
order by Avg_Risk_Score desc
;

/**/
WITH risk_rank AS
(
    SELECT
        d.department_name,
        rr.risk_name,
        rr.risk_score,
        ROW_NUMBER() OVER(
            PARTITION BY d.department_name
            ORDER BY rr.risk_score DESC
        ) AS rn
    FROM departments d
    JOIN assets a
        ON d.department_id = a.department_id
    JOIN risk_register rr
        ON a.asset_id = rr.asset_id
)

SELECT *
FROM risk_rank
WHERE rn = 1;

/**/
with risk_rank as
(
	select department_name, risk_name, risk_score, rank() over (partition by d.department_name
            ORDER BY rr.risk_score DESC
        ) AS rn
    FROM departments d
    JOIN assets a
        ON d.department_id = a.department_id
    JOIN risk_register rr
        ON a.asset_id = rr.asset_id
)
select * from risk_rank
where rn <=2
;

/**/
with risk_total as
(
	 	select department_name, risk_name, risk_score, sum(risk_score) over (partition by d.department_name
        ) AS  department_total_risk
    FROM departments d
    JOIN assets a
        ON d.department_id = a.department_id
    JOIN risk_register rr
        ON a.asset_id = rr.asset_id
)
select * from risk_total
order by department_total_risk desc
;

/**/
with risk_average as
(
	 	select department_name, risk_name, risk_score, round(avg(risk_score) over (partition by d.department_name
        ),2) AS  department_average_risk
    FROM departments d
    JOIN assets a
        ON d.department_id = a.department_id
    JOIN risk_register rr
        ON a.asset_id = rr.asset_id
)
select * from risk_average
WHERE risk_score > department_average_risk
order by department_average_risk desc
;

/**/
WITH risk_lag AS
(
    SELECT
        risk_id,
        assessment_date,
        risk_score,
        LAG(risk_score) OVER (
            PARTITION BY risk_id
            ORDER BY assessment_date
        ) AS previous_risk_score
    FROM risk_assessment_history
)
SELECT *
FROM risk_lag;

/**/
WITH risk_lag AS
(
    SELECT
        risk_id,
        assessment_date,
        risk_score,
        LAG(risk_score) OVER (
            PARTITION BY risk_id
            ORDER BY assessment_date
        ) AS previous_risk_score
    FROM risk_assessment_history
)
SELECT
    risk_id,
    assessment_date,
    risk_score,
    previous_risk_score,
    risk_score - previous_risk_score AS risk_score_change,
    CASE
        WHEN previous_risk_score IS NULL THEN 'First Assessment'
        WHEN risk_score > previous_risk_score THEN 'Increased'
        WHEN risk_score < previous_risk_score THEN 'Decreased'
        ELSE 'Unchanged'
    END AS risk_trend
FROM risk_lag
ORDER BY risk_id, assessment_date;

/**/
WITH risk_lag AS
(
    SELECT
        risk_id,
        assessment_date,
        risk_score,

        LAG(risk_score) OVER (
            PARTITION BY risk_id
            ORDER BY assessment_date
        ) AS previous_risk_score

    FROM risk_assessment_history
)

SELECT
    risk_id,
    assessment_date,
    risk_score,
    previous_risk_score,

    risk_score - previous_risk_score AS risk_score_change

FROM risk_lag
ORDER BY risk_id, assessment_date;

/**/
SELECT
    a.audit_name,
    COUNT(af.finding_id) AS Total_Findings,
    SUM(
        CASE
            WHEN af.finding_status <> 'Resolved' THEN 1
            ELSE 0
        END
    ) AS Open_Findings
FROM audits a
LEFT JOIN audit_findings af
    ON a.audit_id = af.audit_id
GROUP BY a.audit_id, a.audit_name
ORDER BY Open_Findings DESC;

/*Audit Findings Summary*/
SELECT
    a.audit_name,
    COUNT(af.finding_id) AS Total_Findings,
    SUM(
        CASE
            WHEN af.finding_status <> 'Resolved' THEN 1
            ELSE 0
        END
    ) AS Open_Findings
FROM audits a
LEFT JOIN audit_findings af
    ON a.audit_id = af.audit_id
GROUP BY a.audit_id, a.audit_name
ORDER BY Open_Findings DESC;

/*Findings by Severity*/
SELECT
    severity,
    COUNT(*) AS Total_Findings
FROM audit_findings
GROUP BY severity
ORDER BY Total_Findings DESC;

/*Finding Status Summary*/
SELECT
    finding_status,
    COUNT(*) AS Total_Findings
FROM audit_findings
GROUP BY finding_status
ORDER BY Total_Findings DESC;

/*Critical & High Findings*/
SELECT
    af.finding_id,
    a.audit_name,
    ast.asset_name,
    c.control_name,
    af.finding_title,
    af.severity,
    af.finding_status,
    af.target_date
FROM audit_findings af
JOIN audits a
    ON af.audit_id = a.audit_id
JOIN assets ast
    ON af.asset_id = ast.asset_id
JOIN controls c
    ON af.control_id = c.control_id
WHERE af.severity IN ('Critical', 'High')
ORDER BY
    CASE
        WHEN af.severity = 'Critical' THEN 1
        WHEN af.severity = 'High' THEN 2
    END;
    
/*Overdue Findings*/
SELECT
    af.finding_id,
    af.finding_title,
    af.severity,
    af.finding_status,
    af.target_date,
    DATEDIFF(CURRENT_DATE(), af.target_date) AS Days_Overdue
FROM audit_findings af
WHERE af.target_date < CURRENT_DATE()
  AND af.finding_status <> 'Resolved'
ORDER BY Days_Overdue DESC;

/*Department-wise Audit Findings*/
SELECT
    d.department_name AS Department,
    COUNT(af.finding_id) AS Total_Findings,
    SUM(
        CASE
            WHEN af.severity = 'Critical' THEN 1
            ELSE 0
        END
    ) AS Critical_Findings,
    SUM(
        CASE
            WHEN af.severity = 'High' THEN 1
            ELSE 0
        END
    ) AS High_Findings
FROM audit_findings af
JOIN assets a
    ON af.asset_id = a.asset_id
JOIN departments d
    ON a.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY Critical_Findings DESC, High_Findings DESC;

/*Risk Summary*/
SELECT
    d.department_name AS Department,
    COUNT(rr.risk_id) AS Total_Risks,

    SUM(
        CASE
            WHEN rr.risk_level = 'Critical' THEN 1
            ELSE 0
        END
    ) AS Critical_Risks,

    SUM(
        CASE
            WHEN rr.risk_level = 'High' THEN 1
            ELSE 0
        END
    ) AS High_Risks,

    ROUND(AVG(rr.risk_score), 2) AS Average_Risk_Score
FROM risk_register rr
JOIN assets a
    ON rr.asset_id = a.asset_id
JOIN departments d
    ON a.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY Average_Risk_Score DESC;

/*Top 5 Highest Risks*/
SELECT
    rr.risk_name,
    a.asset_name,
    d.department_name,
    rr.risk_level,
    rr.risk_score
FROM risk_register rr
JOIN assets a
    ON rr.asset_id = a.asset_id
JOIN departments d
    ON a.department_id = d.department_id
ORDER BY rr.risk_score DESC
LIMIT 5;

/*Risks Without Controls*/
SELECT
    rr.risk_name,
    a.asset_name,
    d.department_name,
    rr.risk_level,
    rr.risk_score
FROM risk_register rr
JOIN assets a
    ON rr.asset_id = a.asset_id
JOIN departments d
    ON a.department_id = d.department_id
LEFT JOIN risk_control rc
    ON rr.risk_id = rc.risk_id
WHERE rc.risk_id IS NULL
ORDER BY rr.risk_score DESC;

/*Department-wise Control Compliance*/
SELECT
    d.department_name AS Department,
    COUNT(ac.control_id) AS Total_Controls,

    SUM(
        CASE
            WHEN ac.compliance_status = 'Compliant' THEN 1
            ELSE 0
        END
    ) AS Compliant_Controls,

    ROUND(
        SUM(
            CASE
                WHEN ac.compliance_status = 'Compliant' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(ac.control_id),
        2
    ) AS Compliance_Percentage

FROM assets a
JOIN asset_control ac
    ON a.asset_id = ac.asset_id
JOIN departments d
    ON a.department_id = d.department_id

GROUP BY d.department_id, d.department_name
ORDER BY Compliance_Percentage DESC;

/*Controls Due for Review*/
SELECT
    control_id,
    control_name,
    review_date,
    DATEDIFF(review_date, CURRENT_DATE()) AS Days_Until_Review
FROM controls
WHERE review_date BETWEEN CURRENT_DATE()
                      AND DATE_ADD(CURRENT_DATE(), INTERVAL 30 DAY)
ORDER BY review_date;

/*Assets by Criticality*/
SELECT
    criticality,
    COUNT(asset_id) AS Total_Assets
FROM assets
GROUP BY criticality
ORDER BY
    CASE
        WHEN criticality = 'Critical' THEN 1
        WHEN criticality = 'High' THEN 2
        WHEN criticality = 'Medium' THEN 3
        WHEN criticality = 'Low' THEN 4
    END;
    
/*Risk Score Change Over Time*/
WITH risk_lag AS
(
    SELECT
        a.asset_name,
        rr.risk_score,
        rr.risk_review_date,

        LAG(rr.risk_score) OVER (
            PARTITION BY a.asset_id
            ORDER BY rr.risk_review_date
        ) AS Previous_Risk_Score

    FROM assets a
    JOIN risk_register rr
        ON a.asset_id = rr.asset_id
)

SELECT
    asset_name,
    risk_review_date,
    risk_score AS Current_Risk_Score,
    Previous_Risk_Score,
    risk_score - Previous_Risk_Score AS Risk_Score_Change
FROM risk_lag
ORDER BY asset_name, risk_review_date;

/*Overall GRC KPI's */
SELECT

    (SELECT COUNT(*)
     FROM assets) AS Total_Assets,

    (SELECT COUNT(*)
     FROM risk_register) AS Total_Risks,

    (SELECT COUNT(*)
     FROM controls) AS Total_Controls,

    (SELECT COUNT(*)
     FROM audit_findings) AS Total_Findings,

    (SELECT COUNT(*)
     FROM audit_findings
     WHERE finding_status <> 'Resolved') AS Open_Findings,

    (SELECT COUNT(*)
     FROM risk_register
     WHERE risk_level = 'Critical') AS Critical_Risks,

    (SELECT COUNT(*)
     FROM audit_findings
     WHERE severity = 'Critical') AS Critical_Findings;
     

