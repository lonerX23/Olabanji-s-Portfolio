-- create database Store_db;
-- use store_db

-- select * 
-- from Store_ca;

-- DESCRIBE Store_CA;
SELECT
    StoreCategory,
    ROUND(AVG(MonthlySalesRevenue), 2) AS AvgRevenue,
    ROUND(SUM(MonthlySalesRevenue), 2) AS TotalRevenue
FROM Store_CA
GROUP BY StoreCategory
ORDER BY TotalRevenue DESC;

SELECT
    StoreLocation,
    ROUND(AVG(MonthlySalesRevenue),2) AS AvgRevenue,
    COUNT(*) AS NumberOfStores
FROM Store_CA
GROUP BY StoreLocation
ORDER BY AvgRevenue DESC;

SELECT
    CASE
        WHEN MarketingSpend < 15 THEN 'Low'
        WHEN MarketingSpend < 30 THEN 'Medium'
        ELSE 'High'
    END AS MarketingTier,
    ROUND(AVG(MonthlySalesRevenue),2) AS AvgRevenue
FROM Store_CA
GROUP BY MarketingTier;

SELECT
    CASE
        WHEN StoreSize < 200 THEN 'Small'
        WHEN StoreSize < 350 THEN 'Medium'
        ELSE 'Large'
    END AS StoreSizeGroup,
    ROUND(AVG(MonthlySalesRevenue),2) AS AvgRevenue
FROM Store_CA
GROUP BY StoreSizeGroup;

SELECT
    CASE
        WHEN EmployeeEfficiency < 70 THEN 'Low'
        WHEN EmployeeEfficiency < 85 THEN 'Average'
        ELSE 'High'
    END AS EfficiencyGroup,
    ROUND(AVG(MonthlySalesRevenue),2) AS AvgRevenue
FROM Store_CA
GROUP BY EfficiencyGroup
ORDER BY AvgRevenue DESC;

SELECT
    PromotionsCount,
    ROUND(AVG(MonthlySalesRevenue),2) AS AvgRevenue
FROM Store_CA
GROUP BY PromotionsCount
ORDER BY PromotionsCount;

SELECT
    CASE
        WHEN CompetitorDistance <= 5 THEN 'Near'
        WHEN CompetitorDistance <= 10 THEN 'Moderate'
        ELSE 'Far'
    END AS CompetitionLevel,
    ROUND(AVG(MonthlySalesRevenue),2) AS AvgRevenue
FROM Store_CA
GROUP BY CompetitionLevel;

SELECT
    StoreLocation,
    StoreCategory,
    MonthlySalesRevenue,
    RANK() OVER (
        ORDER BY MonthlySalesRevenue DESC
    ) AS RevenueRank
FROM Store_CA;

SELECT
    *,
    NTILE(4) OVER (
        ORDER BY MonthlySalesRevenue DESC
    ) AS RevenueQuartile
FROM Store_CA;

WITH RevenueAnalysis AS (
    SELECT
        MarketingSpend,
        CustomerFootfall,
        EmployeeEfficiency,
        PromotionsCount,
        NTILE(4) OVER (
            ORDER BY MonthlySalesRevenue DESC
        ) AS RevenueQuartile
    FROM Store_CA
)

SELECT
    RevenueQuartile,
    AVG(MarketingSpend) AS AvgMarketing,
    AVG(CustomerFootfall) AS AvgFootfall,
    AVG(EmployeeEfficiency) AS AvgEfficiency,
    AVG(PromotionsCount) AS AvgPromotions
FROM RevenueAnalysis
GROUP BY RevenueQuartile
ORDER BY RevenueQuartile;

