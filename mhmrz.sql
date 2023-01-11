use storeproject;

select * from ware;

select * from customer as c
join profile as p on p.Customer_ID = c.ID;

select table_name from information_schema.tables
where table_schema = 'storeproject' and table_name = 'dishwasher'
or table_schema = 'storeproject' and table_name = 'laundry'
or table_schema = 'storeproject' and table_name = 'solardom'
or table_schema = 'storeproject' and table_name = 'stove'
or table_schema = 'storeproject' and table_name = 'television';


select *  from cart;


select cu.ID , sum(b.Total_Price) as sum from customer as cu
join cart as c on cu.ID = c.Customer_ID
join bill as  b on b.Cart_CID = c.CID
where b.Is_Paid = 1 and b.date between '2021-12-5' and '2024-12-5' group by cu.ID order by sum desc limit 10;



