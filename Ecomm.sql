---------------------------------------------------- IMPORT OF THE DATA BASE -----------------------------------------------------------

-- List of Orders.csv
CREATE TABLE IF NOT EXISTS public.list_of_orders (
    order_id      text,
    order_date    date,
    customername  text,
    state         text,
    city          text
);
COPY public.list_of_orders
FROM 'D:/TAFF/Job Data Analyst/portfolio/GitHub/Ecomm SQL Power BI/DataBase/List of Orders.csv'
DELIMITER ',' CSV HEADER;

-- Order Details.csv
CREATE TABLE IF NOT EXISTS public.order_details (
    order_id      text,
    amount        numeric,
    profit        numeric,
    quantity      integer,
    category      text,
    sub_category  text
);
COPY public.order_details
FROM 'D:/TAFF/Job Data Analyst/portfolio/GitHub/Ecomm SQL Power BI/DataBase/Order Details.csv'
DELIMITER ',' CSV HEADER;

-- Sales target.csv
CREATE TABLE IF NOT EXISTS public.sales_target (
    month_of_order_date text,
    category            text,
    target              numeric
);
COPY public.sales_target
FROM 'D:/TAFF/Job Data Analyst/portfolio/GitHub/Ecomm SQL Power BI/DataBase/Sales target.csv'
DELIMITER ',' CSV HEADER;


-------------------------------------------------- CLEANING DATA -----------------------------------------------------------------------

-- Check columns with NULLS
Select 
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS null_order_date,
    COUNT(*) FILTER (WHERE customername IS NULL) AS null_customer,
    COUNT(*) FILTER (WHERE state IS NULL) AS null_state,
    COUNT(*) FILTER (WHERE city IS NULL) AS null_city
from public.list_of_orders; -- 60 NULLS for each colonms 

select 
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE amount IS NULL) AS null_amount,
    COUNT(*) FILTER (WHERE profit IS NULL) AS null_profit,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS null_quantity,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category,
    COUNT(*) FILTER (WHERE sub_category IS NULL) AS null_sub_category
from public.order_details; -- Any Nulls

select 
    COUNT(*) FILTER (WHERE month_of_order_date IS NULL) AS null_month,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category,
    COUNT(*) FILTER (WHERE target IS NULL) AS null_target
from public.sales_target; -- Anly Nulls

-- Check duplicates
select
order_id,
count(distinct order_id) as distinct_order_id
from list_of_orders
group by order_id
having count(distinct order_id) > 1; -- Any order duplicates

select *,
count(*)
from order_details
group by order_id, category, sub_category, amount, profit, quantity 
having count(*) > 1; -- Any duplicate rows

select *,
count(*)
from sales_target
group by month_of_order_date, category, target
having count(*) > 1; -- Any duplicate rows

-- Check spaces
select *
from public.list_of_orders
where order_id <> trim(order_id) -- any space
or customername <> trim(customername) -- any space
or state <> trim(state) -- Space at the end on the name of "Kerela"
or city <> trim(city); --any space

select *
from public.order_details
where order_id <> trim(order_id) -- any space
or sub_category <> trim(sub_category); -- any space

select *
from public.sales_target
where category <> trim(category); -- any space

-- Check CONSISTENCY
select * 
from order_details
where amount < 0 or quantity < 0 or category = sub_category ; -- Any rows, the dataset is consistent

select *
from sales_target
where target < 0 or target > 20000; -- No rows, the dataset is consistent


-------------------------------------------------- CROSSINGS AND JOINTS -----------------------------------------------------------------

-- Totals
select
sum(amount) as revenue,
sum(profit) as total_profit
from order_details;

-- Revenue, profit, quantity per order, category, subcategory, customer, city, and state































