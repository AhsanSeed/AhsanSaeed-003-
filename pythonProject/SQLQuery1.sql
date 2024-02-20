create database assignment
create table page
(
ID int primary key not null,
FName varchar(12) not null,
LName varchar(12) not null,
Address varchar(23) not null,
Username varchar(23) not null,
Password varchar(23) not null,
)
select * from page
insert into page values (1,'Ahsan','Saeed','Vehari','ahsan',123456)
insert into page values (2,'Mazhar','Saleem','pakpttan','mazhar',123456)
insert into page values (3,'Ali','Saeed','Vehari','ali',123456)
insert into page values (4,'salman','Saeed','Vehari','saalu',123456)