-- 1- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;
    
-- 2- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    pizzas p
        INNER JOIN
    order_details od ON p.pizza_id = od.pizza_id;
    
-- 3- Identify the highest-priced pizza.
SELECT 
    pT.name, p.price
FROM
    pizzas p
        JOIN
    pizza_types pT ON pT.pizza_type_id = p.pizza_type_id
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            pizzas);
            
-- 4- Identify the most common pizza size ordered.
SELECT 
    p.size, SUM(od.quantity) AS total_orders
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_orders DESC
LIMIT 1;

-- 5- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pT.name, SUM(od.quantity) AS total_quantity
FROM
    pizza_types pT
        JOIN
    pizzas p ON pT.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pT.pizza_type_id , pT.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pT.category, SUM(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pT ON p.pizza_type_id = pT.pizza_type_id
GROUP BY pT.category; 

-- 7- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour, COUNT(*) AS total_orders
FROM
    orders
GROUP BY hour
ORDER BY hour;

-- 8- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS total_pizzas
FROM
    pizza_types
GROUP BY category;

-- 9- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(total_pizzas), 2) AS avg_pizzas_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS total_pizzas
    FROM
        orders o
    LEFT JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS t;
    
-- 10- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    p.pizza_type_id,
    pT.name,
    SUM(od.quantity * p.price) AS revenue
FROM
    pizza_types pT
        JOIN
    pizzas p ON p.pizza_type_id = pT.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.pizza_type_id , pT.name
ORDER BY revenue DESC
LIMIT 3;

-- 11- Calculate the percentage contribution of each pizza type to total revenue.
SELECT category, 
ROUND(revenue/SUM(revenue)OVER () * 100 ,2) AS contribution_in_revenue
FROM( SELECT category,
    SUM(od.quantity * p.price) AS revenue
FROM
    pizza_types pT
        JOIN
    pizzas p ON p.pizza_type_id = pT.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pT.category) AS t;

-- 12- Analyze the cumulative revenue generated over time.
SELECT
    order_date,
    revenue_per_day,
    SUM(revenue_per_day) OVER (ORDER BY order_date) AS cumulative_revenue
FROM
(
    SELECT
        o.order_date,
        ROUND(SUM(od.quantity * p.price)) AS revenue_per_day
    FROM pizzas p
    JOIN order_details od
        ON p.pizza_id = od.pizza_id
    JOIN orders o
        ON od.order_id = o.order_id
    GROUP BY o.order_date
) AS t
ORDER BY order_date;

-- 13- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
WITH ranked_pizzas AS (
    SELECT
        pt.category,
        pt.name,
        ROUND(SUM(od.quantity * p.price)) AS revenue,
        RANK() OVER (
            PARTITION BY pt.category
            ORDER BY SUM(od.quantity * p.price) DESC
        ) AS rnk
    FROM pizza_types pt
    JOIN pizzas p
        ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od
        ON p.pizza_id = od.pizza_id
    GROUP BY
        pt.category,
        pt.name
)
SELECT
    name,
    category,
    revenue
FROM ranked_pizzas
WHERE rnk <= 3
ORDER BY
    category,
    revenue DESC;