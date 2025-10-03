SELECT
    p.category,
    COUNT(DISTINCT f.order_id) as order_count,
    ROUND(AVG(f.sales), 2) as avg_sales_per_order,
    ROUND(AVG(f.profit), 2) as avg_profit_per_order
FROM {{ ref('sales_fact') }} AS f
LEFT JOIN {{ ref('product_dim') }} AS p ON f.prod_id = p.prod_id
GROUP BY p.category
ORDER BY avg_sales_per_order DESC