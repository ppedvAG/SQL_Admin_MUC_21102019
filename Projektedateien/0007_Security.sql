--Security

select * from syslogins
--Login und User sind 2 verschiedene Dinge
--Login sind in der master
--User sind in der Benutzerdb
--UserDb speichert nur ZUgriffsrechte
--Das Login kümmert sich um Authentifizierung
--User = Login ---> SID muss gleich sein!!
--Der Name ist egal...

--Rollen = Gruppen
--public = jeder
--schema= Ordner

CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

--Admin


use master

select * from northwind.dbo.orders


select * from northwind..orders

use northwind

select * from orders

--admin
create table it.personal    (itperso int)
create table it.mitarbeiter (itma int)
create table it.projekte    (itpro int)


create table ma.personal    (maperso int)
create table ma.mitarbeiter (mama int)
create table ma.projekte    (mapro int)


select * from personal --geht nicht wg Std Schema
select * from dbo.personal --ebenso wenig

select * from ma.personal --det jeht



use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Otto]
GO

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [Evi]
GO

--evi und Otto können nun "ihre" Tabellen lesen!

--Evi hat keinen Bock immer MA davor zuschreiben

select * from personal

--tabellen anlegen
use [Northwind]
GO
GRANT CREATE TABLE TO [Otto]
GO

use [Northwind]
GO
GRANT ALTER ON SCHEMA::[IT] TO [Otto]
GO


create table it.kst(itkst int)


use [Northwind]
GO
GRANT SELECT ON [IT].[projekte] TO [Evi]
GO




--Neuen IT Admin
--der muss in SQL Server das gleichen tun können wie
--alle andere IT Fuzzis..


--Verwaiste User

use whoamiDB
--user ohne Login
sp_change_Users_login 'Report'

sp_change_users_login 'Update_one', 'jamesB', 'JamesB'

sp_change_users_login 'Auto_fix','jamesBond', NULL, 'ppedv2017!'



--besser:

sp_help_revlogin

CREATE LOGIN [Max] 
WITH PASSWORD = 0x02002137054294D276135EE66DABAB38811EBAD78472BBB07C0C64E26B4AE120916E72FBFA99FED361309DF54E81E203688F68179DD13BD5F1169CBB673D49BF51F8A9CA281F HASHED, SID = 0xAB1B84F217A611478569C55B52E12F4C, DEFAULT_DATABASE = [Northwind], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
 
-






