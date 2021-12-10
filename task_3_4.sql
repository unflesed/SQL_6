create database MyJoinsDB;
use MyJoinsDB;

create table Salaries(
id int auto_increment not null,
salary int not null,
post varchar(30) not null,
primary key(id)
);

create table info(
id int auto_increment not null,
family varchar(30) not null,
dateOfBirth date not null,
adress varchar(30) not null,
primary key(id)
);

create table Employees(
id int auto_increment not null,
name varchar(30) not null,
phone varchar(30) not null,
Salaries_id int not null,
info_id int not null,
foreign key (Salaries_id) references Salaries(id),
foreign key (info_id) references info(id),
primary key(id)
);

insert into Salaries (salary, post)
values (1000, 'worker'),
(1100, 'worker'),
(1200, 'worker'),
(1500, 'manager'),
(1600, 'manager'),
(2500, 'chief');

insert into info (family, dateOfBirth, adress)
values ('Y', 19800101, 'Lenina 12'),
('Y', 19810101,'Pushkina 10'),
('Y', 19820101,'Shevchenko 11'),
('N', 19830101,'Kolasa 5'),
('N', 19840101, 'Kupaly 3'),
('N', 19850101, 'Cetkin 5');

insert into Employees (name, phone, Salaries_id, info_id)
values ('Pupkin', '+19800101', 1, 1),
('Utkin', '+19810101', 2, 2),
('Ivanov', '+19820101', 3, 3),
('Petrov', '+19830101', 4, 4),
('Sidorov', '+19840101',  5, 5),
('Antonov', '+19850101',  6, 6);

select * from Employees;
select * from Salaries;
select * from info;

-- 1 нет необходимости в создании индекса
explain select phone, (select adress from info where employees.info_id = info.id) as adress
from employees;

-- 2 
create index family on info(family); -- Индекс создаётся для увеличения скорости поиска информации

explain select dateOfBirth, (select phone from employees where employees.info_id = info.id) as phone
from info
where family = 'N';

-- 3 
create index post on Salaries(post); -- Индекс создаётся для увеличения скорости поиска информации
explain select (select dateofbirth from info where employees.info_id = info.id) as Birthdate, phone, Name 
from employees
where Salaries_id in (select id from Salaries where post = 'manager');

-- ------------------------- ЗАДАНИЕ 4 ------------------------------------------------------------------
-- 1
create view Contacts
As select name, phone, adress from employees
join info on employees.info_id = info.id;
select * from Contacts;

-- 2
create view BirthDate
As select name, dateOfBirth, phone from employees
join info on employees.info_id = info.id
where family = 'N';
select * from BirthDate;

-- 3
create view ManagersBirth
As select name, dateOfBirth, post, phone from employees
join info on employees.info_id = info.id
join salaries on employees.salaries_id = salaries.id
where post = 'manager';
Select * from ManagersBirth;