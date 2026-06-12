-- create database school_data;
use school_data;

select * 
from student_performance;

SELECT course, AVG(total_score) AS avg_score
FROM student_performance
GROUP BY course;

SELECT 
    course,
    SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) AS pass_count,
    SUM(CASE WHEN passed = 'No' THEN 1 ELSE 0 END) AS fail_count
FROM student_performance
GROUP BY course;

SELECT
    course,
    COUNT(*) AS total_students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY course
ORDER BY avg_score DESC;

SELECT
    passed,
    COUNT(*) AS student_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM student_performance),
        2
    ) AS percentage
FROM student_performance
GROUP BY passed;

SELECT
    gender,
    COUNT(*) AS total_students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(AVG(attendance_pct),2) AS avg_attendance,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY gender;

WITH grouped AS (
    SELECT
        CASE
            WHEN attendance_pct < 60 THEN 'Below 60%'
            WHEN attendance_pct BETWEEN 60 AND 80 THEN '60-80%'
            ELSE 'Above 80%'
        END AS attendance_group,
        total_score,
        passed
    FROM student_performance
)
SELECT
    attendance_group,
    COUNT(*) AS students,
    ROUND(AVG(total_score), 2) AS avg_score,
    ROUND(SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pass_rate
FROM grouped
GROUP BY attendance_group
ORDER BY avg_score DESC;

SELECT
    school_type,
    COUNT(*) AS students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(AVG(attendance_pct),2) AS avg_attendance,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY school_type;

SELECT
    lga,
    COUNT(*) AS students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY lga
ORDER BY avg_score DESC;

SELECT
    internet_access,
    COUNT(*) AS students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(AVG(study_hours_per_week),2) AS avg_study_hours,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY internet_access;

SELECT
    parent_education,
    COUNT(*) AS students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(AVG(attendance_pct),2) AS avg_attendance,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY parent_education
ORDER BY avg_score DESC;

SELECT
    CASE
        WHEN study_hours_per_week <= 5 THEN '0-5 Hours'
        WHEN study_hours_per_week <= 10 THEN '6-10 Hours'
        WHEN study_hours_per_week <= 15 THEN '11-15 Hours'
        ELSE '16+ Hours'
    END AS study_group,
    COUNT(*) AS students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY study_group
ORDER BY avg_score DESC;

SELECT
    grade,
    COUNT(*) AS students,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM student_performance),
        2
    ) AS percentage
FROM student_performance
GROUP BY grade
ORDER BY students DESC;

SELECT
    academic_year,
    COUNT(*) AS students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(AVG(attendance_pct),2) AS avg_attendance,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY academic_year
ORDER BY academic_year;

SELECT
    school_id,
    COUNT(*) AS students,
    ROUND(AVG(total_score),2) AS avg_score,
    ROUND(
        SUM(CASE WHEN passed = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM student_performance
GROUP BY school_id
HAVING COUNT(*) >= 10
ORDER BY avg_score DESC
LIMIT 10;