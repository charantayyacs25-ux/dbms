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

Queries (Questions and Output)
•	Display those managers name whose salary is more than average salary of his employee
select emp_no,ename,sallary from employee e where e.emp_no in
(select mgr_no from employee) and e.sallary>
(select avg(sallary)from employee m where m.mgr_no=e.emp_no);


•	List the name of the managers with the most employees

select m.ename ,count(*) from employee e,employee m
where e.mgr_no=m.emp_no group by m.ename having count(*)=
(select max(mycount)from (select count(*) mycount from employee group by mgr_no)a);


•	Display those managers name whose salary is more than average salary of his employee

select emp_no,ename,sallary from employee e where e.emp_no in
(select mgr_no from employee) and e.sallary>
(select avg(sallary)from employee m where m.mgr_no=e.emp_no);
 
 

•	SQL Query to find the employee details who got second maximum incentive in Febrauary 2019.

select *from employee e,incentive i
where e.emp_no=i.emp_no and 2 = ( select count(*) from incentive j
where i.incentive_amount <= j.incentive_amount );


•	Retrieve the employee numbers of all employees who work on project located in Bengaluru, Hyderabad, or Mysuru


SELECT e.emp_no
FROM employee e, assigned_to a, project p WHERE e.emp_no = a.emp_no AND a.pno = p.pno
AND p.ploc IN ('BENGALURU', 'HYDERABAD', 'MYSURU');





 
•	Write a SQL query to find those employees whose net pay are higher than or equal to the salary of any other employee in the company

SELECT distinct e.ename FROM employee e,incentive i
WHERE (SELECT max(sallary+incentive_amount)
FROM employee,incentive) >= ANY (SELECT sallary
FROM employee e1
where e.dept_no=e1.dept_no);
