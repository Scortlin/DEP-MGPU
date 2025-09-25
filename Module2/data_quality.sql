-- Задание 1: [Создать представление по возвратам]
-- проверка количества записей
SELECT COUNT(*) 
FROM public.returns_view;
-- проверка дублей (результат пустой - дублей нет) 
SELECT order_id, product_id, COUNT(*) AS cnt
FROM public.returns_view
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;
-- проверка по конкретному заказу
SELECT *
FROM public.returns_view
WHERE order_id = 'CA-2016-143336';

-- Задание 2: [Рассчитать прибыль по регионам]
-- проверка количества записей
SELECT COUNT(*) 
FROM public.profit_by_region;
-- проверка суммы прибыли
SELECT 
    (SELECT SUM(total_profit) FROM public.profit_by_region) as total1,
    (SELECT SUM(profit) FROM public.orders) as total2;
-- проверка отдельного региона
SELECT 
    'profit_by_region' as name_table,
    total_profit as profit
FROM public.profit_by_region
WHERE region = 'West'

UNION ALL

SELECT 
    'orders' as name_table,
    SUM(profit) as profit
FROM public.orders
WHERE region = 'West';


-- Задание 3: [Определить количество клиентов по сегментам]
-- проверка количества сегментов
SELECT DISTINCT segment
FROM public.orders;
-- проверка дублей (результат пустой - дублей нет)
SELECT customer_id, COUNT(DISTINCT segment) AS seg_count
FROM public.orders
GROUP BY customer_id
HAVING COUNT(DISTINCT segment) > 1;














