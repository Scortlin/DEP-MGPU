-- Задание 1: [Создать представление по возвратам]
CREATE OR REPLACE VIEW public.returns_view AS
SELECT DISTINCT -- оставляем только уникальные строки
    o.order_id, -- идентификатор заказа
    o.order_date, -- дата заказа
    o.customer_id, -- идентификатор покупателя
    o.customer_name, -- имя покупателя
    o.product_id, -- идентификатор товара
    o.product_name, -- название товара
    o.category, -- категория товара
    o.subcategory, -- подкатегория товара
    o.sales, -- продажи (доход)
    o.quantity, -- количество товара
    o.discount, -- скидка
    o.profit, -- прибыль
    o.region, -- регион
    r.returned -- возвраты товара
FROM public.orders o
JOIN public.returns r
  ON o.order_id = r.order_id;  -- соединение заказов с возвратами по идентификатору заказа


-- Задание 2: [Рассчитать прибыль по регионам]
CREATE TABLE public.profit_by_region AS
SELECT 
    region,  -- регион, по которому считается прибыль
    SUM(profit) AS total_profit -- суммарная прибыль для региона
FROM public.orders -- из таблицы заказов
GROUP BY region -- группировка по региону
ORDER BY total_profit DESC; -- сортировка результата: сначала самые прибыльные регионы


-- Задание 3: [Определить количество клиентов по сегментам]
SELECT 
    segment, -- сегмент клиента (Consumer, Corporate, Home Office)
    COUNT(DISTINCT customer_id) AS customer_count -- количество уникальных клиентов в сегменте
FROM public.orders -- из таблицы заказов
GROUP BY segment -- группировка по сегменту
ORDER BY customer_count DESC; -- сортировка по убыванию числа клиентов

