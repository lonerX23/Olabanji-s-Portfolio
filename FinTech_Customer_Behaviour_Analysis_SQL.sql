-- create database personal_data
use personal_data;

select * from personal_finance;

-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE personal_finance
-- SET savings_goal_met = 'Not Applicable'
-- WHERE savings_goal_met IS NULL
  -- AND category <> 'Savings';

-- SET SQL_SAFE_UPDATES = 1;

-- UPDATE personal_finance
-- SET notes = 'No Note'
-- WHERE notes IS NULL;

-- SELECT COUNT(*)
-- FROM personal_finance
-- WHERE category <> budget_category;

SELECT
    year,
    month,
    transaction_type,
    ROUND(SUM(amount_ngn),2) AS total_amount
FROM personal_finance
GROUP BY year, month, transaction_type
ORDER BY year, month;

SELECT
    category,
    ROUND(SUM(amount_ngn),2) AS total_spent
FROM personal_finance
WHERE transaction_type = 'Expense'
GROUP BY category
ORDER BY total_spent DESC;

SELECT
    category,
    ROUND(SUM(amount_ngn),2) AS total_income
FROM personal_finance
WHERE transaction_type = 'Income'
GROUP BY category
ORDER BY total_income DESC;

SELECT
    bank,
    COUNT(*) AS transactions,
    ROUND(SUM(amount_ngn),2) AS total_amount
FROM personal_finance
GROUP BY bank
ORDER BY total_amount DESC;

SELECT
    payment_method,
    COUNT(*) AS transactions,
    ROUND(SUM(amount_ngn),2) AS total_amount
FROM personal_finance
GROUP BY payment_method
ORDER BY transactions DESC;

SELECT
    year,
    transaction_type,
    ROUND(SUM(amount_ngn),2) AS total_amount
FROM personal_finance
GROUP BY year, transaction_type
ORDER BY year;

SELECT
    user_id,
    SUM(amount_ngn) AS total_spent,
    CASE
        WHEN SUM(amount_ngn) >= 1000000 THEN 'High'
        WHEN SUM(amount_ngn) >= 500000 THEN 'Medium'
        ELSE 'Low'
    END AS spending_segment
FROM personal_finance
WHERE transaction_type = 'Expense'
GROUP BY user_id;

SELECT
    month,
    ROUND(SUM(amount_ngn),2) AS total_expense
FROM personal_finance
WHERE transaction_type = 'Expense'
GROUP BY month
ORDER BY FIELD(
    month,
    'January','February','March','April',
    'May','June','July','August',
    'September','October','November','December'
);

SELECT
    year,
    month,
    ROUND(
        SUM(CASE WHEN transaction_type = 'Income' THEN amount_ngn ELSE 0 END),
        2
    ) AS income,
    ROUND(
        SUM(CASE WHEN transaction_type = 'Expense' THEN amount_ngn ELSE 0 END),
        2
    ) AS expense,
    ROUND(
        (
            SUM(CASE WHEN transaction_type = 'Income' THEN amount_ngn ELSE 0 END)
            -
            SUM(CASE WHEN transaction_type = 'Expense' THEN amount_ngn ELSE 0 END)
        ),
        2
    ) AS savings
FROM personal_finance
GROUP BY year, month
ORDER BY year, month;

SELECT
    user_id,
    ROUND(
        SUM(CASE WHEN transaction_type='Expense'
            THEN amount_ngn ELSE 0 END)
        /
        SUM(CASE WHEN transaction_type='Income'
            THEN amount_ngn ELSE 0 END)
        *100,
        2
    ) AS expense_income_ratio
FROM personal_finance
GROUP BY user_id
HAVING expense_income_ratio IS NOT NULL
ORDER BY expense_income_ratio DESC;

SELECT
    year,
    month,
    ROUND(SUM(amount_ngn),2) AS total_income
FROM personal_finance
WHERE transaction_type='Income'
GROUP BY year, month
ORDER BY total_income DESC
LIMIT 10;

SELECT
    user_id,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_ngn),2) AS lifetime_value
FROM personal_finance
GROUP BY user_id
ORDER BY lifetime_value DESC;

SELECT
    bank,
    ROUND(
        SUM(amount_ngn) * 100 /
        (SELECT SUM(amount_ngn)
         FROM personal_finance),
        2
    ) AS market_share_pct
FROM personal_finance
GROUP BY bank
ORDER BY market_share_pct DESC;

SELECT
    category,
    ROUND(SUM(amount_ngn),2) AS expense,
    ROUND(
        SUM(amount_ngn) * 100 /
        (
            SELECT SUM(amount_ngn)
            FROM personal_finance
            WHERE transaction_type='Expense'
        ),
        2
    ) AS contribution_pct
FROM personal_finance
WHERE transaction_type='Expense'
GROUP BY category
ORDER BY contribution_pct DESC;