# 🍕 SQL Pizza Sales Analysis

## Project Overview

This project analyzes pizza sales data using SQL to uncover business insights related to revenue generation, customer preferences, product performance, and ordering patterns.

The analysis was performed on a relational database containing order, product, and category information. Various SQL techniques were used to answer real-world business questions and transform raw transactional data into actionable insights.

---

## Dataset

The project uses four related tables:

### Orders
Stores order-level information.
- order_id
- order_date
- order_time

### Order Details
Stores details of pizzas included in each order.
- order_details_id
- order_id
- pizza_id
- quantity

### Pizzas
Contains pizza sizes and prices.
- pizza_id
- pizza_type_id
- size
- price

### Pizza Types
Contains pizza names, categories, and ingredients.
- pizza_type_id
- name
- category
- ingredients

---

## Database Schema

```text
orders
   │
   ▼
order_details
   │
   ▼
pizzas
   │
   ▼
pizza_types
```

---

## Business Questions Solved

1. Retrieve the total number of orders placed.
2. Calculate total revenue generated from pizza sales.
3. Identify the highest-priced pizza.
4. Find the most common pizza size ordered.
5. List the top 5 most ordered pizza types.
6. Calculate total quantity sold by pizza category.
7. Analyze order distribution by hour.
8. Examine category-wise pizza distribution.
9. Calculate average pizzas ordered per day.
10. Identify top revenue-generating pizzas.
11. Calculate revenue contribution by category.
12. Analyze cumulative revenue over time.
13. Determine top revenue-generating pizzas within each category.

---

## SQL Concepts Demonstrated

- INNER JOIN
- LEFT JOIN
- Aggregate Functions
  - SUM()
  - COUNT()
  - AVG()
  - ROUND()
- GROUP BY
- ORDER BY
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- DENSE_RANK()

---

## Key Insights

- Generated over **$817K** in total revenue.
- Large-sized pizzas were the most preferred by customers.
- Classic pizzas recorded the highest overall demand.
- Customer orders peaked during lunch and evening hours.
- Revenue was distributed relatively evenly across categories.
- Window functions were used to track cumulative revenue trends and category-level rankings.

---

## Tools & Technologies

- SQL
- MySQL
- MySQL Workbench
- Microsoft Word
- Canva

---

## Repository Structure

```text
SQL-Pizza-Sales-Analysis/
│
├── dataset/
│   ├── orders.csv
│   ├── order_details.csv
│   ├── pizzas.csv
│   └── pizza_types.csv
│
├── analysis_queries.sql
├── Pizza Sales Analysis.pdf
└── README.md
```

---

## Project Files

| File | Description |
|--------|-------------|
| analysis_queries.sql | SQL queries used for analysis |
| Pizza Sales Analysis.pdf | Complete project report |
| dataset/ | Dataset used in the project |

---

## Learning Outcomes

Through this project, I gained hands-on experience in:

- Querying relational databases
- Writing business-focused SQL queries
- Performing sales and revenue analysis
- Using joins, aggregations, subqueries, and window functions
- Extracting meaningful insights from transactional data

---

## Author

**Unnati Singh**  
BCA (Data Science & AI)
