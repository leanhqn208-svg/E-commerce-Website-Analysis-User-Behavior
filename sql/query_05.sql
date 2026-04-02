---QUERY5----
--Query 05: Average number of transactions per user that made a purchase in July 2017.
SELECT
    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS Month, 
    Sum(totals.transactions)/ COUNT(Distinct fullVisitorId)
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*` 
,UNNEST(hits) AS hits
,UNNEST(hits.product) AS product
WHERE product.productRevenue IS NOT NULL 
GROUP BY Month
ORDER BY Month;
