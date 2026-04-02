---QUERY6----
--Query 06: Average amount of money spent per session. Only include purchaser data in July 2017.
      FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS Month,
      ROUND(SUM(product.productRevenue)/1e6/ COUNT(totals.visits),2)
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*` 
,UNNEST(hits) AS hits
,UNNEST(hits.product) AS product
WHERE product.productRevenue IS NOT NULL 
AND totals.transactions IS NOT NULL 
GROUP BY Month
ORDER BY Month;
