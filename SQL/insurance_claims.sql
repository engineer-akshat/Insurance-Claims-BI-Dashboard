CREATE TABLE insurance_claims(
	months_as_customer INTEGER,
    age INTEGER,
    policy_number TEXT,
    policy_bind_date DATE,
    policy_state TEXT,
    policy_csl TEXT,
    policy_deductable INTEGER,
    policy_annual_premium FLOAT,
    umbrella_limit INTEGER,
    insured_zip TEXT,
    insured_sex TEXT,
    insured_education_level TEXT,
    insured_occupation TEXT,
    insured_hobbies TEXT,
    insured_relationship TEXT,
    capital_gains INT,
    capital_loss INTEGER,
    incident_date DATE,
    incident_type TEXT,
    collision_type TEXT,
    incident_severity TEXT,
    authorities_contacted TEXT,
    incident_state TEXT,
    incident_city TEXT,
    incident_location TEXT,
    incident_hour_of_the_day INTEGER,
    number_of_vehicles_involved INTEGER,
    property_damage TEXT,
    bodily_injuries INTEGER,
    witnesses INTEGER,
    police_report_available TEXT,
    total_claim_amount FLOAT,
    injury_claim FLOAT,
    property_claim FLOAT,
    vehicle_claim FLOAT,
    auto_make TEXT,
    auto_model TEXT,
    auto_year INTEGER,
    fraud_reported TEXT
);

select * from insurance_claims LIMIT 10;

-- Column overview
SELECT COUNT(*) AS total_rows FROM insurance_claims;


-- Null value analysis (example)
SELECT COUNT(*) FROM insurance_claims WHERE property_damage IS NULL;


--unique region/city
SELECT DISTINCT incident_city FROM insurance_claims;
SELECT DISTINCT incident_state FROM insurance_claims;


--KPI metrics, 
--Average Claim Amount
SELECT ROUND(AVG(total_claim_amount):: numeric, 2) 
AS avg_total_claim 
FROM insurance_claims;


--Fraud Rate by Region
SELECT incident_state,
       COUNT(*) AS total_claims,
       SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_cases,
       ROUND(100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY incident_state
ORDER BY fraud_rate_pct DESC;


--claim volume by automaker
SELECT auto_make, COUNT(*) AS claim_count
FROM insurance_claims
GROUP BY auto_make
ORDER BY claim_count DESC;


--monthly claims
SELECT DATE_TRUNC('month', incident_date) AS month,
       COUNT(*) AS claim_count
FROM insurance_claims
GROUP BY month
ORDER BY month;


--avg claim by customer education level
SELECT insured_education_level,
       ROUND(AVG(total_claim_amount):: numeric, 2) AS avg_claim
FROM insurance_claims
GROUP BY insured_education_level
ORDER BY avg_claim DESC;


CREATE VIEW vw_avg_claim_by_region AS
SELECT incident_state,
       ROUND(AVG(total_claim_amount):: numeric, 2) AS avg_claim
FROM insurance_claims
GROUP BY incident_state;



