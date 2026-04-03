--- to see the entair table rows and columns---

select * from customer_data
use praveenDB
---to see top 10 rows ---

SELECT TOP (10) * FROM customer_data

--- to see the entair count of order_id---

select count(*) from customer_data

---Total amount in the entair table----

select sum(delivery_fee) as total_amount from customer_data

---unique values ---

select distinct(city) from customer_data

--- In entair table only premium type restaurant emp cnt and total prechase amount by every city--

select city,restaurant_type, count(order_id) as total_id,sum(delivery_fee) as total_amount from customer_data
where restaurant_type ='Premium'
group by city,restaurant_type

-- in this table  we show all city names in order wise  and restaurant_type, total_amount and total_cnt---

select city,restaurant_type, count(order_id) as total_id,sum(delivery_fee) as total_amount from customer_data
group by restaurant_type,city
order by city

use praveenDB

--which restaurant_type is more sales in the table--

select restaurant_type, sum(delivery_fee) as total_amount from customer_data
group by restaurant_type
order by total_amount desc

--specific age group cal--

select sum(delivery_fee) as total_amt,count(*) as age22_cnt from customer_data
where age='22'

select * from customer_data

---how many orders placed in all citys--

select city,count(city) as each_city_cnt from customer_data
group by city
order by each_city_cnt desc

--Based on every city we give ranking--

select city,cuisine,count(order_id) as no_of_ords,
ROW_NUMBER() over(partition by(city) order by count(order_id) desc) as rank_foods
from customer_data
group by cuisine,city

--highist delivery fee --

select city,restaurant_type,cuisine, max(delivery_fee) as high_delivery_fee from customer_data
group by city,restaurant_type,cuisine

--highest delivery_fee by using dense_rank--

select delivery_fee,city from (
select delivery_fee,city,
DENSE_RANK() over(order by delivery_fee desc) as rnk
 from customer_data ) t
 where rnk = 1


--second highest delivery fee in normal method--

select city,restaurant_type,cuisine, max(delivery_fee) as second_highest_fee from customer_data
where delivery_fee <(select max(delivery_fee)from customer_data)
group by city,restaurant_type,cuisine


--second highest delivery fee using dense_rank method--

select delivery_fee,city from (
	select delivery_fee,city,
	DENSE_RANK()over(order by delivery_fee desc) as rnk 
	from customer_data ) t
where rnk=2


use praveenDB

--3 rd highest salary using dense_rank---

select delivery_fee,city from 
( select delivery_fee,city,
DENSE_RANK() over(order by delivery_fee desc) as rnk from customer_data) t
where rnk =3

--3rd highest salary using nested function--

select city,max(delivery_fee) as third_sal from customer_data
where delivery_fee<(select max(delivery_fee) from customer_data
where delivery_fee<(select max(delivery_fee)from customer_data))
group by city 
