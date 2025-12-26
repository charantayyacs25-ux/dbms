

select customername from depositer d,bankaccount a
where d.accno=a.accno and a.branchname="SBI_residencyroad" group by d.customername having count(d.customername)>=2;



select customername,accno from depositer
where accno in (select accno from bankaccount a,branch b where a.branchname=b.branchname and b.branchcity="delhi");





delete from bankaccount where branchname in
(select branchname from branch where branchcity="bombay"); select*from bankaccount;
 
 



create view v2 as
select branchname,sum(balance) from bankaccount group by branchname; select *from v2;



update bankaccount set balance=balance*1.05; set sql_safe_updates=0;
select *from bankaccount;
 


select distinct customername from depositer union(select customername from bankcustomer);




select *from loan order by amount desc;
