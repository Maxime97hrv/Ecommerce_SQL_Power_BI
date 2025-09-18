---------------------------------------------------- IMPORT OF THE DATA BASE -----------------------------------------------------------

-- List of Orders.csv
CREATE SCHEMA Public;

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
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id, -- we put a filter to output only Nulls rows
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
from public.list_of_orders
group by order_id
having count(distinct order_id) > 1; -- Any order duplicates

select *,
count(*)
from public.order_details
group by order_id, category, sub_category, amount, profit, quantity 
having count(*) > 1; -- Any duplicate rows

select month_of_order_date, category,
count(*)
from public.sales_target
group by month_of_order_date, category 
having count(*) > 1; -- Any duplicate rows

-- Check spaces
select *
from public.list_of_orders
where order_id <> trim(order_id) -- any space
or customername <> trim(customername) -- any space
or state <> trim(state) -- Space at the end on the name of "Kerela"
or city <> trim(city); -- any space

select *
from public.order_details
where order_id <> trim(order_id) -- any space
or category <> trim(category) -- any space
or sub_category <> trim(sub_category); -- any space

select *
from public.sales_target
where category <> trim(category); -- any space

-- Check CONSISTENCY
select * 
from public.order_details
where amount < 0 or quantity < 0 or category = sub_category ; -- Any rows, the dataset is consistent

select *
from public.sales_target
where target < 0 or target > 20000; -- No rows, the dataset is consistent

-- Cleaning
CREATE SCHEMA clean_ecomm; -- Create the folder schema Clean_ecomm to put our datasets

create table clean_ecomm.list_of_orders as -- for the leaning we don't want spaces on the state.
select
order_id,
order_date,
customername,
trim(state) as state, -- for delete spaces on the state Kerala
city
FROM public.list_of_orders
where order_id is not null; -- we remove the null lines

create table clean_ecomm.order_details as
select * from public.order_details; -- no treatment required

create table clean_ecomm.sales_target as
select * from public.sales_target; -- no treatment required
-------------------------------------------------- DESCRIPTIVE STATISTICS -----------------------------------------------------------------

-- Totals
select
sum(amount) as total_amount,
sum(profit) as total_profit,
sum(quantity) as total_quantity,
count(distinct order_id) as number_of_orders
from clean_ecomm.order_details;

select 
sum(target) as target_revenue
from clean_ecomm.sales_target;

-- Revenue, profit, quantity per order
select
order_id,
sum(amount) as amount_per_order,
sum(profit) as profit_per_order,
sum(quantity) as quantity_per_order
from clean_ecomm.order_details
group by order_id
order by order_id asc;

-- Revenue, profit, quantity per category
select
category,
sum(amount) as amount_per_category,
sum(profit) as profit_per_category,
sum(quantity) as quantity_per_category
from clean_ecomm.order_details
group by category
order by category asc;

-- Revenue, profit, quantity per sub_category
select
category,
sub_category,
sum(amount) as amount_per_sub_category,
sum(profit) as profit_per_sub_category,
sum(quantity) as quantity_per_sub_category
from clean_ecomm.order_details
group by category,sub_category 
order by category asc, sub_category asc;

-- Revenue, profit, quantity per customer
select
l.customername,
sum(o.amount) as amount_per_customer,
sum(o.profit) as profit_per_customer,
sum(o.quantity) as quantity_per_customer
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id 
group by l.customername
order by l.customername ;

-- Revenue, profit, quantity per city
select
l.city,
sum(o.amount) as amount_per_customer,
sum(o.profit) as profit_per_customer,
sum(o.quantity) as quantity_per_customer
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id 
group by l.city
order by l.city ;

-- Revenue, profit, quantity per state
select
l.state,
sum(o.amount) as amount_per_customer,
sum(o.profit) as profit_per_customer,
sum(o.quantity) as quantity_per_customer
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id 
group by l.state
order by l.state ;

-- Compare sales with target by month
with order_by_month as
(select
to_char(l.order_date,'Mon-YY') as order_date, -- display format MMM-YY ex Apr-18 (month of the year)
date_trunc('month', l.order_date) as order_month, -- Type date with month as unit
sum(o.amount) as amount, -- we want the revenue total by month, same for the profit and quantity
sum(o.profit) as profit,
sum(o.quantity) as quantity
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id
group by date_trunc('month', l.order_date), to_char(l.order_date,'Mon-YY')) -- date_trunc: the sum must be group by the month of the year

select 
obm.order_date, -- we want the month of the year
obm.amount, obm.profit, obm.quantity,
sum(s.target) as target
from order_by_month obm
inner join sales_target s on s.month_of_order_date = obm.order_date
group by obm.order_month, obm.order_date, obm.amount, obm.profit, obm.quantity
order by obm.order_month;




























