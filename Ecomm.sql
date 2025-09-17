-- IMPORT OF THE DATA BASE

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







