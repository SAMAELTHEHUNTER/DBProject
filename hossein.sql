use storeproject;

select sum(whc.Count) as sum from ware as w
join ware_has_cart as whc on w.WID = whc.Ware_WID
join cart as c on whc.Cart_CID = c.CID
join bill as b on b.Cart_CID = c.CID
where b.Is_Paid = 1 group by w.WID order by sum desc limit 10;


select * from ware
where Discount > 15;


select p.PID , p.Name from provider as p
join provider_has_ware as phw on p.PID = phw.Provider_PID
join ware as w on w.WID = phw.Ware_WID
where w.name = 'Stove1';


select w.WID , w.name , p.PID , p.Name , phw.price from provider_has_ware as phw
join provider as p on phw.Provider_PID = p.PID
join ware as w on w.WID = phw.Ware_WID
where phw.Ware_WID = 2 order by phw.price limit 1;



select table_name from information_schema.tables
where table_name = 'dishwasher'or table_name = 'laundry'or table_name = 'solardom'or table_name = 'stove'or table_name = 'television';