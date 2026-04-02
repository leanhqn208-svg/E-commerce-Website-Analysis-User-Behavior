---QUERY4----
--Query 04: Average number of pageviews by purchaser type (June & July 2017)
WITH purchase as (SELECT
    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS Month,
     Sum(totals.pageviews)/count(DISTINCT(fullVisitorId) ) avg_pageviews_purchase
   FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*` 
  ,UNNEST(hits) AS hits
  ,UNNEST(hits.product) AS product
  WHERE date BETWEEN '20170601' AND '20170731'
  AND totals.transactions >= 1
  AND product.productRevenue IS NOT NULL
  GROUP BY Month 
  ORDER BY Month ASC
  ),
  no_purchase as (SELECT
    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS Month,
     Sum(totals.pageviews)/count(DISTINCT(fullVisitorId) ) avg_pageviews_non_purchase
   FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*` 
  ,UNNEST(hits) AS hits
  ,UNNEST(hits.product) AS product
  WHERE date BETWEEN '20170601' AND '20170731'
  AND totals.transactions IS NULL
  AND product.productRevenue IS NULL
  GROUP BY Month 
  ORDER BY Month ASC)
SELECT
  p.Month,
  p.avg_pageviews_purchase,
  np.avg_pageviews_non_purchase
FROM purchase p
LEFT JOIN no_purchase np
ON p.Month = np.Month;