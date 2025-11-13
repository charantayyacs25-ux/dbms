create database emp1;
use emp1;

create table dept (
  deptno decimal(2,0) primary key,
  dname varchar(14) default null,
  loc varchar(13) default null
);

create table emp (
  empno decimal(4,0) primary key,
  ename varchar(10) default null,
  mgr_no decimal(4,0) default null,
  hiredate date default null,
  sal decimal(9,2) default null,
  deptno decimal(2,0),
  foreign key (deptno) references dept(deptno)
    on delete cascade
    on update cascade
);

create table incentives (
  empno decimal(4,0),
  incentive_date date,
  incentive_amount decimal(10,2),
  primary key (empno, incentive_date),
  foreign key (empno) references emp(empno)
    on delete cascade
    on update cascade
);

create table project (
  pno int primary key,
  pname varchar(30) not null,
  ploc varchar(30)
);

create table assigned_to (
  empno decimal(4,0),
  pno int,
  job_role varchar(30),
  primary key (empno, pno),
  foreign key (empno) references emp(empno)
    on delete cascade
    on update cascade,
  foreign key (pno) references project(pno)
    on delete cascade
    on update cascade
);

insert into dept values (10,'accounting','mumbai');
insert into dept values (20,'research','bengaluru');
insert into dept values (30,'sales','delhi');
insert into dept values (40,'operations','chennai');

insert into emp values (7369,'adarsh',7902,'2012-12-17',80000.00,20);
insert into emp values (7499,'shruthi',7698,'2013-02-20',16000.00,30);
insert into emp values (7521,'anvitha',7698,'2015-02-22',12500.00,30);
insert into emp values (7566,'tanvir',7839,'2008-04-02',29750.00,20);
insert into emp values (7654,'ramesh',7698,'2014-09-28',12500.00,30);
insert into emp values (7698,'kumar',7839,'2015-05-01',28500.00,30);
insert into emp values (7782,'clark',7839,'2017-06-09',24500.00,10);
insert into emp values (7788,'scott',7566,'2010-12-09',30000.00,20);
insert into emp values (7839,'king',null,'2009-11-17',500000.00,10);
insert into emp values (7844,'turner',7698,'2010-09-08',15000.00,30);
insert into emp values (7876,'adams',7788,'2013-01-12',11000.00,20);
insert into emp values (7900,'james',7698,'2017-12-03',9500.00,30);
insert into emp values (7902,'ford',7566,'2010-12-03',30000.00,20);

insert into incentives values (7499,'2019-02-01',5000.00);
insert into incentives values (7521,'2019-03-01',2500.00);
insert into incentives values (7566,'2022-02-01',5070.00);
insert into incentives values (7654,'2020-02-01',2000.00);
insert into incentives values (7654,'2022-04-01',879.00);
insert into incentives values (7521,'2019-02-01',8000.00);
insert into incentives values (7698,'2019-03-01',500.00);
insert into incentives values (7698,'2020-03-01',9000.00);
insert into incentives values (7698,'2022-04-01',4500.00);

insert into project values (101,'ai project','bengaluru');
insert into project values (102,'iot','hyderabad');
insert into project values (103,'blockchain','bengaluru');
insert into project values (104,'data science','mysuru');
insert into project values (105,'autonomus systems','pune');

insert into assigned_to values (7499,101,'software engineer');
insert into assigned_to values (7521,101,'software architect');
insert into assigned_to values (7566,101,'project manager');
insert into assigned_to values (7654,102,'sales');
insert into assigned_to values (7521,102,'software engineer');
insert into assigned_to values (7499,102,'software engineer');
insert into assigned_to values (7654,103,'cyber security');
insert into assigned_to values (7698,104,'software engineer');
insert into assigned_to values (7900,105,'software engineer');
insert into assigned_to values (7839,104,'general manager');

show tables;
select * from dept;
select * from emp;
select * from incentives;
select * from project;
select * from assigned_to;

select empno from emp
where empno not in (select empno from incentives);

select m.ename, count(*) as employee_count
from emp e, emp m
where e.mgr_no = m.empno
group by m.ename
having count(*) = (
  select max(mycount)
  from (
    select count(*) as mycount
    from emp
    group by mgr_no
  ) a
);

select *
from emp m
where m.empno in (select mgr_no from emp)
  and m.sal > (
    select avg(e.sal)
    from emp e
    where e.mgr_no = m.empno
);

select *
from emp e, incentives i
where e.empno = i.empno
  and 2 = (
    select count(*)
    from incentives j
    where i.incentive_amount <= j.incentive_amount
);

select *
from emp e
where e.deptno = (
  select e1.deptno
  from emp e1
  where e1.empno = e.mgr_no
);

select e.empno
from emp e, assigned_to a, project p
where e.empno = a.empno
  and a.pno = p.pno
  and p.ploc in ('bengaluru','hyderabad','mysuru');

select e.ename, e.empno, d.dname, a.job_role, d.loc as dept_location, p.ploc as project_location
from emp e
join dept d on e.deptno = d.deptno
join assigned_to a on e.empno = a.empno
join project p on a.pno = p.pno
where d.loc = p.ploc;

select distinct e.ename
from emp e, incentives i
where (select max(sal + incentive_amount)
       from emp, incentives)
      >= any (select sal from emp e1 where e.deptno = e1.deptno);
