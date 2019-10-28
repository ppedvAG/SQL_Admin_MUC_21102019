--Tabellen
--PK, Beziehungen, 
--1. Sichten 
--2. Adhoc
--3. Prozeduren
--4. F()

--langsam--> Schnell
--4   3  1    2


--Sicht
--gemerket Abfrage
--Sicht gibt immer nur das zurück, was in der Sicht angeben wurde
--Sicht verhält sich wie eine Tabelle
--auch: I UP DEL Rechte
--Sicht hat keine Daten (= Abfrage)

alter view v1 
as
select spx from t1-- where id = 10


select * from v1 where id = 10


select * from (select * from t1 where id = 100) txy

--aber warum macht man denn Sichten?

--komplexe Abfragen, (wiederholen sich oft) zu vereinfachen


--Daten filtern per Sicht: horiz + vertik Filter

use northwind

select * from employees

create view vemp
as
select employeeid, lastname, firstname, Homephone from employees
where country = 'USA'

--UP DEL wirkt sich nur auf die Daten aus, die die Sicht zurückgibt
select * from vemp


--ins kann man alles, aber nur wenn Pflichtfelder gefüllt sind
--was ist besser?
--egal .. beides gleich schnell
select * from vemp

select employeeid, lastname, firstname, Homephone from employees
where country = 'USA'


select * from customers c
	inner join orders o on o.customerid = c.customerid
	where c.country = 'UK' and o.freight < 1


select * from customers c
	inner join orders o on o.customerid = c.customerid
	where c.country = 'USA' and o.freight < 2


	--Prozeduren
create proc gpproc1
as
select * from orders where orderid = 10250

--kann aber auch das


create proc gpproc1 @oid as int
as
select * from orders where orderid = @oid
GO

exec gpproc1 10251

--Proz kann auch INS, UP; del und Sel beiinhalten
--Einsatzgebiet
--komplette Logik abbildbar

--sie ist im Regelfall schneller, weil die Kompilierzeit entfällt
--bei ersten Aufruf wird der Plan fixiert
--bei jedem weiteren Aufruf wird der Plan wiederverwendet


--Funktion..sind in der Regel immer schlecht
--

select * from customers where customerid like 'A%'


select * from customers where left(customerid,1) ='A'


--F()   adhoc|Sicht   Proz

--F(/) sind extrem flexibel

select f(sp), f(wert) from f(wert) where f(Sp) > f(wert)
