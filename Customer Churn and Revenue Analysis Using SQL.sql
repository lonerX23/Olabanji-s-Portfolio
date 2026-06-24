-- create database customer_db;
use customer_db;

select * from customer_churn_business_dataset;

SELECT
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn_business_dataset;

SELECT
    customer_segment,
    COUNT(*) AS customers,
    SUM(churn) AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn_business_dataset
GROUP BY customer_segment
ORDER BY churn_rate DESC;

SELECT
    SUM(CASE WHEN churn = 1 THEN total_revenue ELSE 0 END)
        AS revenue_lost,
    SUM(total_revenue) AS total_revenue,
    ROUND(
        SUM(CASE WHEN churn = 1 THEN total_revenue ELSE 0 END)
        * 100.0 / SUM(total_revenue),
        2
    ) AS revenue_loss_percentage
FROM customer_churn_business_dataset;

SELECT
    contract_type,
    COUNT(*) AS customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn_business_dataset
GROUP BY contract_type
ORDER BY churn_rate DESC;

SELECT
    customer_segment,
    ROUND(AVG(total_revenue),2) AS avg_customer_value,
    ROUND(MAX(total_revenue),2) AS highest_customer_value
FROM customer_churn_business_dataset
GROUP BY customer_segment
ORDER BY avg_customer_value DESC;

SELECT
    support_tickets,
    COUNT(*) AS customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn_business_dataset
GROUP BY support_tickets
ORDER BY support_tickets;

SELECT
    csat_score,
    COUNT(*) AS customers,
    SUM(churn) AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn_business_dataset
GROUP BY csat_score
ORDER BY csat_score;

SELECT
    payment_method,
    COUNT(*) AS customers,
    SUM(churn) AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn_business_dataset
GROUP BY payment_method
ORDER BY churn_rate DESC;

SELECT
    churn,
    ROUND(AVG(email_open_rate),2) AS avg_email_open_rate,
    ROUND(AVG(marketing_click_rate),2) AS avg_click_rate
FROM customer_churn_business_dataset
GROUP BY churn;

SELECT
    CASE
        WHEN monthly_logins < 10 THEN 'Low Engagement'
        WHEN monthly_logins BETWEEN 10 AND 20 THEN 'Medium Engagement'
        ELSE 'High Engagement'
    END AS engagement_level,
    COUNT(*) AS customers,
    ROUND(AVG(total_revenue),2) AS avg_revenue,
    ROUND(SUM(churn) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn_business_dataset
GROUP BY engagement_level
ORDER BY avg_revenue DESC;

SELECT
    country,
    COUNT(*) AS customers,
    ROUND(AVG(total_revenue),2) AS avg_revenue,
    ROUND(SUM(churn) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn_business_dataset
GROUP BY country
ORDER BY avg_revenue DESC;