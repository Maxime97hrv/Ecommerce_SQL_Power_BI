---------------------------------------------------- IMPORT OF THE DATA BASE -----------------------------------------------------------

-- List of Orders.csv
DROP SCHEMA IF EXISTS Public CASCADE;
DROP SCHEMA IF EXISTS clean_ecomm CASCADE;

CREATE SCHEMA Public; -- for the data imported
CREATE SCHEMA clean_ecomm; -- Create the folder schema Clean_ecomm to put our datasets

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

-- Identify orphaned order_ids
SELECT od.order_id
FROM public.order_details od
LEFT JOIN public.list_of_orders lo 
       ON od.order_id = lo.order_id
WHERE lo.order_id IS NULL; -- Any orphaned ID

-- Check CONSISTENCY
select * 
from public.order_details
where amount < 0 or quantity < 0 or category = sub_category ; -- Any rows, the dataset is consistent

select *
from public.sales_target
where target < 0 or target > 20000; -- No rows, the dataset is consistent

-- Cleaning
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

-- CROSSINGS AND JOINTS

-- Totals for the year
select
sum(amount) as total_amount,
sum(profit) as total_profit,
sum(quantity) as total_quantity,
100*sum(profit)/sum(amount) as marge,
count(distinct order_id) as number_of_orders
from clean_ecomm.order_details;

-- Total target for the year
select 
sum(target) as target_revenue
from clean_ecomm.sales_target;

-- Revenue, profit, quantity per order
select
order_id,
sum(amount) as amount_per_order,
sum(profit) as profit_per_order,
100*sum(profit)/sum(amount) as marge,
sum(quantity) as quantity_per_order
from clean_ecomm.order_details
group by order_id
order by profit_per_order desc;

-- Revenue, profit, quantity per category
select
category,
sum(amount) as amount_per_category,
sum(profit) as profit_per_category,
100*sum(profit)/sum(amount) as marge,
sum(quantity) as quantity_per_category,
100*sum(amount)/sum(sum(amount)) over() as market_share  -- Market share
from clean_ecomm.order_details
group by category
order by profit_per_category asc;

-- Revenue, profit, quantity by category and sub_category
select
category,
sub_category,
sum(amount) as amount_per_sub_category,
sum(profit) as profit_per_sub_category,
100*sum(profit)/sum(amount) as marge,
sum(quantity) as quantity_per_sub_category,
100*sum(amount)/sum(sum(amount)) over() as market_share  -- Market share
from clean_ecomm.order_details
group by category,sub_category 
order by category, profit_per_sub_category desc;

-- Revenue, profit, quantity by customer
select
l.customername,
sum(o.amount) as amount_per_customer,
sum(o.profit) as profit_per_customer,
100*sum(profit)/sum(amount) as marge,
sum(o.quantity) as quantity_per_customer
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id 
group by l.customername
order by profit_per_customer desc;

-- Revenue, profit, quantity by city
select
l.city,
sum(o.amount) as amount_per_city,
sum(o.profit) as profit_per_city,
sum(profit)/sum(amount) as marge,
sum(o.quantity) as quantity_per_city
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id 
group by l.city
order by profit_per_city desc;

-- Revenue, profit, quantity by state
select
l.state,
sum(o.amount) as amount_per_customer,
sum(o.profit) as profit_per_customer,
sum(profit)/sum(amount) as marge,
sum(o.quantity) as quantity_per_customer
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id 
group by l.state
order by profit_per_customer desc;

-- Compare sales with target by month
with order_by_month as
(select
date_trunc('month', l.order_date) as order_month, -- Type date with month as unit
TO_CHAR(l.order_date, 'Mon-YY') AS order_date_label, --display format MMM-YY ex Apr-18 (month of the year)
sum(o.amount) as amount, -- we want the revenue total by month, same for the profit and quantity
sum(o.profit) as profit,
sum(profit)/sum(amount) as marge,
sum(o.quantity) as quantity
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id
group by date_trunc('month', l.order_date), to_char(l.order_date,'Mon-YY')) -- date_trunc: the sum must be group by the month of the year

select
obm.order_date_label,
obm.amount, 
lag(obm.amount) over(order by obm.order_month) as previsous_month_amount,
(obm.amount - lag(obm.amount) over(order by obm.order_month))/(lag(obm.amount) over(order by obm.order_month)) as growth_MoM, -- Monthly growth
obm.profit, obm.marge, obm.quantity,
sum(s.target) as target,
sum(s.target) - obm.amount as diff_amount_target
from order_by_month obm
inner join sales_target s on s.month_of_order_date = obm.order_date_label
group by obm.order_date_label, obm.order_month, obm.amount, obm.profit, obm.marge, obm.quantity
order by obm.order_month;

-- Compare sales with target by category
select
o.category,
sum(o.amount) as sum_amount_category,
sum(o.profit) as sum_profit_category,
sum(profit)/sum(amount) as marge,
sum(o.quantity) as sum_quantity_category,
s.sum_target_category
from clean_ecomm.order_details o
inner join (select category, sum(target) as sum_target_category from clean_ecomm.sales_target group by category) as s
on s.category = o.category
group by o.category, s.sum_target_category
order by sum_profit_category desc;


-- Compare sales with target by month and category
with order_by_month_cat as
(select
to_char(l.order_date,'Mon-YY') as order_date, -- display format MMM-YY ex Apr-18 (month of the year)
date_trunc('month', l.order_date) as order_month, --Type date with month as unit
o.category,
sum(o.amount) as sum_amount_per_mcat, -- we want the revenue total by month, same for the profit and quantity
sum(o.profit) as sum_profit_per_mcat,
sum(o.quantity) as sum_quantity_per_mcat
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id
group by date_trunc('month', l.order_date), to_char(l.order_date,'Mon-YY'), o.category)

select
oc.order_date, oc.category, oc.sum_amount_per_mcat, oc.sum_profit_per_mcat, oc.sum_profit_per_mcat/oc.sum_amount_per_mcat as marge,
oc.sum_quantity_per_mcat,
st.target
from order_by_month_cat oc
inner join clean_ecomm.sales_target st on st.month_of_order_date = oc.order_date and st.category = oc.category
order by oc.order_month, oc.category, oc.sum_profit_per_mcat desc;

-- AGGREGATIONS/SYNTHESES

-- total revenue, profit, quantity by order and customer
select
l.customername,
l.order_id, 
sum(o.amount) as amount_per_customer,
sum(o.profit) as profit_per_customer,
sum(profit)/sum(amount) as marge,
avg(o.profit) as avgprofit_per_customer,
sum(o.quantity) as quantoty_per_customer
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o
on l.order_id = o.order_id 
group by l.customername, l.order_id
order by l.customername;

-- By region (state/city): total revenue, total profit, total sales, top cities.
with city_profit as 
(select
l.state,
l.city,
sum(o.amount) as amount_per_city,
sum(o.profit) as profit_per_city,
sum(profit)/sum(amount) as marge,
sum(o.quantity) as quantity_per_city
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details as o
on o.order_id = l.order_id
group by l.state, l.city), ranked as
(select *,
cume_dist() over(order by profit_per_city desc) as pr from city_profit -- cumulative proportion of lines whose value is ≤ the current value
)

select state, city, amount_per_city, profit_per_city, marge, quantity_per_city
from ranked
where pr <= 0.33 -- curent value for the top cities we want to retain
order by profit_per_city desc;

-------------------------------------- INTERMEDIATE TABLES OR VIEWS TO SIMPLIFY POWER BI -------------------------------------------------------

--sales_summary : Revenue, profit, margin by category/subcategory and month

create table clean_ecomm.sales_summary as
with order_by_month_cat as
(select
to_char(l.order_date,'Mon-YY') as order_date_text, -- display format MMM-YY ex Apr-18 (month of the year)
date_trunc('month', l.order_date)::date as order_month, --Type date with month as unit
o.category,
o.sub_category,
sum(o.amount) as sum_amount_per_sub, -- we want the revenue total by month, same for the profit and quantity
sum(o.profit) as sum_profit_per_sub,
sum(o.quantity) as sum_quantity_per_sub
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id
group by date_trunc('month', l.order_date), to_char(l.order_date,'Mon-YY'), o.category, o.sub_category)

select
oc.order_date_text as order_date,
oc.order_month,
oc.category, oc.sub_category, oc.sum_amount_per_sub, oc.sum_profit_per_sub,
COALESCE(100 * oc.sum_profit_per_sub / NULLIF(oc.sum_amount_per_sub, 0), 0) AS marge,
oc.sum_quantity_per_sub,
st.target
from order_by_month_cat oc
inner join clean_ecomm.sales_target st on to_char(oc.order_month, 'Mon-YY') = st.month_of_order_date and st.category = oc.category
order by oc.order_month, oc.category, oc.sub_category, oc.sum_profit_per_sub desc;

-- client_summary: Total revenue, total profit, number of orders per customer and per city

create table clean_ecomm.client_summary as
select
l.state,
l.city,
l.customername,
sum(o.amount) as amount_per_customer,
sum(o.profit) as profit_per_customer,
100 * sum(o.profit) / NULLIF(sum(o.amount), 0) as marge,
sum(o.quantity) as quantity_per_customer
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id 
group by l.customername, l.state, l.city
order by l.state, l.city, amount_per_customer;

-- performance_vs_target: Actual revenue vs. target by category and month, with variance and % achieved.

create table clean_ecomm.performance_vs_target as
with order_by_month_cat as
(select
to_char(l.order_date,'Mon-YY') as order_date, -- display format MMM-YY ex Apr-18 (month of the year)
date_trunc('month', l.order_date) as order_month, --Type date with month as unit
o.category,
sum(o.amount) as sum_amount_per_mcat -- we want the revenue total by month and category
from clean_ecomm.list_of_orders l
inner join clean_ecomm.order_details o on o.order_id = l.order_id
group by date_trunc('month', l.order_date), to_char(l.order_date,'Mon-YY'), o.category)

select
oc.order_date as order_date_text, oc.order_month, oc.category, oc.sum_amount_per_mcat,
st.target,
oc.sum_amount_per_mcat - st.target as Diff_amount_target,
100*oc.sum_amount_per_mcat/st.target as achievement
from order_by_month_cat oc
inner join clean_ecomm.sales_target st on st.month_of_order_date = oc.order_date and st.category = oc.category
order by oc.order_month, oc.category;






