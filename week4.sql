create database Employee; use Employee;
Create table

create table department(
dept_no decimal(2,0) primary key, dname varchar(20),
dloc varchar(20));

create table employee (
emp_no decimal (4,0) primary key, ename varchar(20),
mgr_no decimal(4,0), hire_date date, sallary decimal(7,2),
dept_no decimal(2,0),
foreign key (dept_no) references department (dept_no) on delete cascade on update cascade);

create table incentive(
emp_no decimal(4,0) references employee (emp_no) on delete cascade on update cascade, incentive_date date,
incentive_amount decimal(10,2), primary key (emp_no,incentive_date));

create table project ( pno int primary key,
pname varchar(30)not null, ploc varchar(30));

create table assigned_to(
emp_no decimal(4,0) references employee(emp_no) on delete cascade on update cascade, pno int references project(pno) on delete cascade on update cascade,
job_role varchar(30), primary key (emp_no,pno));
