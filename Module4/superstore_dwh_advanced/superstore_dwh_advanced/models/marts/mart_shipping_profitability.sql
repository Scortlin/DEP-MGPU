WITH company_avg_profit AS (
    SELECT
        ROUND(AVG(profit), 2) AS avg_company_profit
    FROM {{ref('int_sales_orders')}}
),
shipping_profit AS (
    SELECT
        ship_mode,
        ROUND(SUM(profit), 2) AS total_profit,
        COUNT(DISTINCT order_id) AS order_count
    FROM {{ref('int_sales_orders')}}
    GROUP BY ship_mode
)
SELECT
    sp.ship_mode, --способ доставки
    sp.order_count, --количество заказов для способа доставки
    sp.total_profit, --общая прибыль способа доставки
    cap.avg_company_profit, --средняя прибыль по компании
    (sp.total_profit - cap.avg_company_profit) as profit_difference, --разница между общей прибыли способа доставки и средней прибыли по компании
    CASE
        WHEN cap.avg_company_profit != 0 THEN
            ROUND(((sp.total_profit - cap.avg_company_profit) / cap.avg_company_profit) * 100, 2)
        ELSE 0
    END AS total_profit_percentage –-процентное отклонение
FROM shipping_profit sp
CROSS JOIN company_avg_profit cap
ORDER BY sp.total_profit DESC
