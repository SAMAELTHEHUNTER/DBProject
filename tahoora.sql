use storeproject;

-- namayesh 10 sefaresh akhar karbar
select *
from cart
join customer
on Customer_ID = ID
where ID = 1
limit 10;

-- namayesh taminkonandegan kala marboot be yek shahr
select *
from provider
where City = 'Tehran';

-- namayesh karbaran marboot be yek shahr
select *
from customer
where City = 'Sari';

-- namayesh miyangin forosh foroshgah dar mah
select avg(Total_Price)
from bill
where Date between '2022-08-01' and '2022-08-31' and Is_Paid = 1;

-- namayesh mizan forosh yek kala dar mah
select sum(Count)
from bill as b
join cart as c on b.Cart_CID = c.CID
join ware_has_cart as whc on c.CID = whc.Cart_CID
where b.date between  '2022-08-01' and '2022-08-31' and whc.Ware_WID = 12;

-- namayesh 10 sefaresh akhar karbar
select *
from cart
join customer
on Customer_ID = ID
where ID = 1
limit 10;
