---QUERY7----
--Query 07: Other products purchased by customers who bought "YouTube Men's Vintage Henley" (July 2017)
WITH customer_id as (
  SELECT 
      DISTINCT (fullVisitorId) AS user_id
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*` ,
  UNNEST(hits) hits,
  UNNEST(hits.product) product
WHERE totals.transactions >= 1
  AND productRevenue IS NOT NULL
  AND product.v2ProductName = "YouTube Men's Vintage Henley" 
)

SELECT 
    product.v2ProductName AS other_purchased_products,
    SUM(product.productQuantity) quantity
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*` 
JOIN customer_id
ON customer_id.user_id = fullVisitorId,
UNNEST(hits) hits,
UNNEST(hits.product) product
WHERE totals.transactions >= 1
  AND productRevenue IS NOT NULL
  AND v2ProductName != "YouTube Men's Vintage Henley"
GROUP BY other_purchased_products
ORDER BY quantity DESC;