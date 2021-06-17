CREATE DATABASE ORG; 
SHOW DATABASES; 
USE ORG; 

create table worker (
    work_id INT not null primary key auto_increment,
    first_name CHAR(25),
	last_name CHAR(25),
	salary INT(15),
	joining_date DATETIME,
	department char(25)
);

select * from worker;
insert into worker(work_id,first_name,last_name,salary,joining_date,department)values
       (001,'nikit','makwana',50000,'20-02-13 08:08:00','data_scientist'),
       (002,'naresh','makwana',40000,'20-01-08 08:08:08','data_analyst'),
       (003,'raju','shrimali',30000,'20-03-13 09:10:10','accountant'),
       (004,'ketan','saresa',60000,'20-04-08 10:10:10','developer'),
       (005,'aman','jonna',35000,'20-05-08 12:12:12','marketing'),
       (006,'panthesh','saresa',20000,'20-06-13 06:06:06','designer');

select * from worker;

create table Bonus(
		worker_ref_id INT,
		bonus_amount INT(10),
		bonus_date datetime,
		foreign key (worker_ref_id)
		references worker(work_id)
		on delete cascade
);

select * from Bonus;

insert into Bonus(worker_ref_id,bonus_amount,bonus_date)values
       (001,5000,'16-02-20'),
	   (002,3000,'16-02-11'),
	   (003,4000,'16-02-13'),
	   (004,4500,'16-02-11'),
	   (005,6000,'16-02-17');

select * from Bonus;

create table title(
	worker_ref_id INT,
	worker_title CHAR(25),
	affected_from datetime,
	foreign key (worker_ref_id)
	references worker(work_id)
	on delete cascade
);

insert into title (worker_ref_id,worker_title,affected_from) values
			(001,'manager','2016-02-20 00:00:00'),
			(002,'Executive','2014-02-11 00:00:00'),
			(003,'Asst.manager','2016-02-13 00:00:00'),
			(004,'Lead','2015-02-11 00:00:00'),
			(005,'Executive','2016-02-17 00:00:00');

select * from title;

select first_name from worker;
select first_name as worker_name from worker;     /*select column name with change it name*/
select upper(first_name)from worker; /*uppaercase */
select department from worker;
select distinct department from worker;/*unique value*/
select substring(first_name,1,3) from worker;/*select first 3 char of first_name*/
select INSTR(first_name,binary'a') from worker where first_name='naresh';
select INSTR(first_name,'a') from worker where first_name='naresh';
select rtrim(first_name) from worker;          /*remove right side space*/
select ltrim(department) from worker;          /*remove left side space*/
select distinct length(department) from worker;
select replace(first_name,'a','A') from worker;
select concat(first_name,' ',last_name) as complete_name from worker;
select * from worker order by first_name asc;
select * from worker order by first_name asc,department desc;
select * from worker order by work_id desc;
select * from worker where first_name in('nikit','naresh');
select * from worker where first_name not in('nikit','naresh');
select * from worker where department like 'developer%';
select * from worker where department='developer';
select * from worker where first_name like '%a%';
select * from worker where first_name like '%a';/*end with a*/
select * from worker where first_name like 'a%';/*start with a*/
select * from worker where first_name like '_____h';/*end with h and contain six alphabet*/
select * from worker where salary between 30000 and 40000;/*it contains both boundry values also*/
select * from worker where year(joining_date)=2020 and day(joining_date)=13;
select count(*) from worker where department='accountant';

select concat(first_name,' ',last_name) as Worker_name,salary from worker where work_id
              in (select work_id from worker where salary between 30000 and 40000);/*give full name and selected salary*/

select concat(first_name,' ',last_name) as Worker_name,salary from worker where salary between 30000 and 40000; 

select department ,count(work_id) no_of_workers 
from worker 
group by department 
order by no_of_workers desc;/* SQL Query To Fetch The No. Of Workers For Each Department In The Descending Order.*/

/* SQL Query To Print Details of the Workers who are also Managers */
/*inner join*/
select distinct w.first_name,T.worker_title 
from worker w
inner join title T 
on w.work_id = T.worker_ref_id 
and T.worker_title in ('manager');

/* SQL Query To Fetch Duplicate Records Having Matching Data In Some Fields Of A Table */
select worker_title,affected_from,count(*)
from title 
group by worker_title,affected_from
having count(*)>1;

select * from worker where mod(work_id,2)<>0;/*odd rows*/
select * from worker where mod(work_id,2)=0;/*even rows*/

create table worker2 select * from worker;/*to clone a table from another table*/
select * from worker2;

/* An SQL Query To Fetch Intersecting Records Of Two Tables */
/*(select * from worker)
intersect
(select * from title);*/

select work_id,first_name,last_name,salary,joining_date,department
from worker
join title
on worker.work_id=title.worker_ref_id;
/*we also get info about same element of rows for two tables depending which column is same,we gather it using join */
create table test(
		worker_ref_id INT,
		extra_pay INT(10),
		foreign key (worker_ref_id)
		references worker(work_id)
		on delete cascade
);

insert into test (worker_ref_id,extra_pay)values
       (001,2000),
       (003,4000),
       (005,6000);

select * from test;

select work_id,first_name,last_name,salary,joining_date,department
from worker
join test
on worker.work_id=test.worker_ref_id;

select curdate();
select now();

select * from worker order by salary desc limit 2;/*top 2*/
select * from worker order by salary asc limit 2;/*bottom 2*/
select salary from worker limit 2;/*give first two elements of rows*/

select * from worker;
select salary from worker order by salary desc limit 2,1;/*give 3rd highest salary=limit N-1,1*/
select salary from worker order by salary desc limit 4,1;/*give 5th highest salary*/

alter table bonus change worker_ref_id worker_rid int;
select * from bonus;

/*this query gives the workers who have same salary*/
select distinct w.work_id,w.first_name,w.salary
from worker w,worker w1
where w.salary=w1.salary
and w.work_id!=w1.work_id

select max(salary) from worker
where salary not in (select max(salary) from worker);/*gives the second highest salary*/

select  first_name,department from worker w
where w.department='data_scientist'
union all
select first_name,department from worker w1
where w1.department='data_scientist';/* An SQL Query To Show One Row Twice In Results From A Table*/

/*max salary with name*/
select first_name,salary from worker where salary=(select max(salary) from worker);

/*select 50% records from table*/
select * from worker where work_id<=(select count(work_id)/2 from worker);

select distinct department,count(work_id) no_of_workers
from worker
group by department
having no_of_workers<5;/*gives total no. of workers <5 department wise*/

select department,count(work_id) no_of_worker
from worker
group by department;/*give the total no. of workers in each department*/

/* SQL Query To Show The Last Record From A Table*/
select * from worker order by work_id desc limit 1;

/* An SQL Query To Fetch The First Row Of A Table*/
select * from worker order by work_id asc limit 1;

alter table worker drop column joining_date;
select * from worker;
select * from worker2;
/*if you want to alter table or drop some columns for some reason then always you should create a new table like original*/

delete from worker where work_id=6;
select * from worker;

select first_name,salary,department from worker
where salary=(select max(salary)from worker);

select max(first_name),max(salary),max(department) from worker group by department;
/*give the employee name who have max salary in their respective department*/
select first_name,max(salary),department from worker group by department;

create table test2(
       name char(25),
       vetan int(15),
       kam char(25)
);

insert into test2 (name,vetan,kam)values
       ('ronak',50000,'python'),
       ('vijay',25000,'python'),
       ('mayank',30000,'js'),
       ('rishi',25000,'js');
select * from test2;
select name,max(vetan),kam from test2 group by kam;
select sum(vetan),kam from test2 group by kam;/*total salary paid in each kam*/

update worker
set last_name='jonnalagadda'
where work_id=005;
select * from worker;

update worker
set salary=100000
where first_name='nikit';
select * from worker;

delete from worker
where work_id=002;
select * from worker;

select first_name, salary from worker where salary=(select max(Salary) from worker);
