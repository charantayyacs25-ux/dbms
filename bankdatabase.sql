create database Bank; use Bank;
Create table

create table branch(
branchname varchar(50) primary key, branchcity varchar(50),
assets int);

create table bankaccount( accno int primary key, branchname varchar(50), balance int,
foreign key(branchname) references branch (branchname));

create table bankcustomer ( customername varchar(20) primary key, customerstreet varchar(50),
city varchar(50));

create table depositer( customername varchar(20), accno int,
foreign key(customername)references bankcustomer(customername), foreign key(accno)references bankaccount(accno));

create table loan ( loannumber int, branchname varchar(50), amount int,
foreign key(branchname) references branch(branchname));
insert into branch values("SBI_chamrajpet","bengaluru",50000); insert into branch values("SBI_residencyroad","bengaluru",10000); insert into branch values("SBI_shivajiroad","bombay",20000); insert into branch values("SBI_parlimentroad","delhi",10000); insert into branch values("SBI_jantarmantar","delhi",20000); select*from branch;


insert into bankaccount values(1,"SBI_chamrajpet",2000); insert into bankaccount values(2,"SBI_residencyroad",5000); insert into bankaccount values(3,"SBI_shivajiroad",6000); insert into bankaccount values(4,"SBI_parlimentroad",9000); insert into bankaccount values(5,"SBI_jantarmantar",8000); insert into bankaccount values(6,"SBI_shivajiroad",4000); insert into bankaccount values(8,"SBI_residencyroad",4000); insert into bankaccount values(9,"SBI_parlimentroad",3000); insert into bankaccount values(10,"SBI_residencyroad",5000); insert into bankaccount values(11,"SBI_jantarmantar",2000); select*from bankaccount;
 
insert into bankcustomer values("avinash","bull_temple_road","bengaluru"); insert into bankcustomer values("dinesh","bannergatt_road","bengaluru"); insert into bankcustomer values("mohan","nationalcollege_road","bengaluru"); insert into bankcustomer values("nikil","akbar_road","delhi");
insert into bankcustomer values("ravi","prithviraj_road","delhi"); select*from bankcustomer;



insert into depositer values("avinash",1); insert into depositer values("dinesh",2); insert into depositer values("nikil",4); insert into depositer values("ravi",5); insert into depositer values("avinash",8); insert into depositer values("nikil",9); insert into depositer values("dinesh",10); insert into depositer values("nikil",11); select*from depositer;
