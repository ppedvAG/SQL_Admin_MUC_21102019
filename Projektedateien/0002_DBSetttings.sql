create database MUCDB

/*
Code ist ok, aber technisch ohje

Wie groß ist die DB?
16MB (5, 7MB)

Wachstumsrate?
64MB  (1MB für Daten und 10% Log)


--permanente Vergrösserungen und evtl Fragmentierung usw..

--geht das auch besser: ?
Anfangsgröße: wie groß in 3 Jahren.. ist dem Backup  egal
Vergrößerung: selten , aber nicht auffällig




*/

use mucdb;

create table t1 (id int identity, spx char(4100));


--20000 DS


insert into t1
select 'XY'
GO 20000

--geschätzt 50MB
---Sekunden: 22...31...33....35
--hat aber 160MB


--5 MS 157*6*
select 5*157.. in summe 800ms

--


create table t2 (id int identity, spx char(4100));



insert into t2
select 'XY'
GO 20000

--20 Sekunden...26 Sekunden.. 41 Sekunden 

--dagegen
select * into t3 from t1 ---1 Sekunde!!!!

--wieso select into so schnell
--wieso 160MB??


--SQL mag Massenoparationen
--> TX und Batches machen das Ding langsam

--160MB

--Otto
--char(50): 50  'otto                          '
--varchar(50): 4 'Otto'
--nchar(50): 100 'otto      * 2                    '
--nvarchar(50): 8 'Otto' * 2


create table tx (id int identity, spx char(4100), spy char(4100))

--weil die Mindestzeilengröße 8211 betragen würde, einschließlich 7 Bytes an internen Verwaltungsbytes. Dies überschreitet die maximal zulässige Größe für Tabellenzeilen von 8060 Bytes.


--spx XY aber char 4100
-- pro Seiten ein DS nur einer
--bei 20000 DS --> 20000* 8Kb --> 160 MB


--Unser Ziel: weniger Seiten --> weniger RAM --> weniger CPU

--DB Design!!!!


dbcc showcontig('t1')

--- Mittlere Seitendichte (voll).....................: 50.79%
--- Gescannte Seiten.................................: 20000

--nach Büroschluss!!
dbcc showcontig()




--Normalisierung ist ok... aber auch langsam.. Redundanz ist besser aber man Redundanz pflegen




--..Beziehungen



select * from customers


delete from customers where customerid = 'PARIS'

--was kann man gegen schlechte Auslastung von Seiten tun?

--bessere Datentypen
--> APP? .. leider ja..
--Tabellen Redsign.. APP.. ja shit!!

--Kompression
--Row und Page
--Row.. Leerzeichen hinten raus... Datensätze auf den Seiten zusammenziehen
--Page und dann noch Kompression (Algori...)

--Aber was kostet das..
--1: die app funktioninert noch.. Client bekommt Origdaten
--2: aber dekompression kostet: CPU
--3: dafür weniger Seiten

--Messen
set statistics io, time on --Anzahl der Seiten, CPU Dauer , gesamte Dauer in ms
							--aber aufpassen: nicht in Schleifen!!!


select * from t3
--, CPU-Zeit = 171 ms, verstrichene Zeit = 1,09 Sek
--20000 Seiten


select * from t1
--29 Seiten bei kanpp 0 ms und 1,1 Sek

--Kompression:
--40 bis 60%
--mehr CPU Verbrauch
--RAM weniger. auf dem Server blieben die DAten immer komprimiert..auch im Speicher

