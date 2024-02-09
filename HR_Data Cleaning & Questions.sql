USE work;
SELECT * FROM work.hr;
DESCRIBE hr;

SELECT hire_date FROM hr;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Update to set null termdate values to '0000-00-00'
UPDATE hr
SET termdate = NULL
WHERE termdate = '0000-00-00';

-- Update to convert non-null termdate values to DATE format
UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d'))
WHERE termdate IS NOT NULL;

-- Alter the column to DATE type
ALTER TABLE hr
MODIFY COLUMN termdate DATE;


ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT birthdate,age FROM hr;

SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest 
FROM hr;

SELECT count(*)FROM hr WHERE age < 18;

-- QUESTIONS 

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;

-- 2. What is the race/ethnicity of the employees in the company?
SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company?
SELECT 
	min(age) AS youngest,
    max(age) AS oldest 
FROM hr
WHERE age >= 18 AND termdate IS NULL;

SELECT 
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group;
-- Finding out how the age group is also distributed among the genders 
SELECT 
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,gender,
    COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group,gender
ORDER BY age_group,gender;
-- value count of the data dat falls under the condition WHERE age >= 18 AND termdate IS NULL
SELECT COUNT(*) AS total_rows
FROM hr
WHERE age >= 18 AND termdate IS NULL;

-- 4. How many Employees Work at Headquaters versus remote location?
SELECT location, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location;

-- 5. What is the average rate of employees who have been terminated?
SELECT 
	CEILING(AVG(DATEDIFF(termdate, hire_date)) / 365) AS avg_length_employment_years
FROM hr
WHERE termdate IS NOT NULL AND age >= 18;

-- 6. How does the gender distribition vary across departments and job titles?
SELECT department,gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY department,gender
ORDER BY department;

-- 7. What is the distribution of job title across the company?
SELECT jobtitle, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Find the department with the highest turnover rate
SELECT 
    department,
    total_count,
    terminated_count,
    terminated_count / total_count AS termination_rate
FROM (
    -- Calculate total count and terminated count for each department
    SELECT 
        department,
        COUNT(*) AS total_count,
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    WHERE age >= 18
    GROUP BY department
) AS department_turnover
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state? 
SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the companys employee count changed over time based on hire and term date?
-- Calculate the change in employee count over time based on hire and termination dates
SELECT
    year,
    hires,
    terminated_count,
    hires - terminated_count AS net_change,
    ROUND((hires - terminated_count) / hires * 100, 2) AS net_change_percent
FROM (
    -- Calculate the number of hires and terminations for each year
    SELECT
        YEAR(hire_date) AS year,
        COUNT(*) AS hires,
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate <= curdate() AND termdate IS NOT NULL AND age >= 18
GROUP BY department;


    
    



