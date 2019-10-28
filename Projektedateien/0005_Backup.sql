--Backup

/*

Vollst V
sichert Dateien + Pfade (allerdings nur Daten aus den Dateien)
Checkpoint
Zeitpunkt

Transaktionsprotokollsicherung  T (INS, UP, DEL..)
T enthält eine Liste an Anweisungen
und führt diese beim Restore wieder aus

Differentielle  D
immer Diff zum letzten V
Checkpoint
Zeitpunkt

Seiten



!V
	T
	T
	T
	T
 D
	T
	T
	T
	T
 !D
!	T
!	T
!	T


V TTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT

schnellste Restore: V
--T werden alle 30 min gesichert

wie klange dauert das 3te T von oben
max 30min
so lange wie die Anw dauerten 

Das D macht den Restore kürzer und sicherer


--Wichtig: RecoveryModel - Wiederherstellungsmodel

Einfach
..werden TX nach dem Commit automatische gelöscht
T leert sich selber
es wird I UP DEL protkolliert, BULK nur rudimentär
kein T Backup
--> Sinnvoll: unkritische DB, selten sichern..


Massenprotokolliert
es wird nix gelöscht aus dem T
T muss gesichert, da es sonst weiter wächst
T Sicherung leert das T 
protokolliert wie einfach
auf Sek theoretisch restorebar , ausser es passierte ein Bulk

Vollständige
protkolliert alles mit
auch IX auch Bulg genau
auf Sek restorebar






Wie lange darf die DB ausfallen
Wie groß  in Zeit darf der Datenverlust


*/

begin tran

delete from o1 
where orderid = 10250


select * from o1

rollback
commit

--Situationen

--logischer Fehler: Datenverlust

--HDD mit DB weg

--SQL Server ist weg, aber HDD ist da


--eine Datei der DB ist weg


--wenn ich weiss, dass etwas passieren könnte

create database testdb
--RecoverModel=FULL

BACKUP DATABASE [testdb] 
TO  DISK = N'C:\_BOOMBACKUP\testdb.bak' 
WITH NOFORMAT, NOINIT,  
NAME = N'testdb-Vollständig Datenbank Sichern', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10


use testdb
select * into kunden from northwind..customers

select * into Best from northwind..orders

create table t1 (id int identity, spx char(4100));
GO


insert into t1
select 'XY'
GO 30000


--V  TTT D TTT D TTT D TTT


BACKUP LOG [testdb] TO  DISK = N'C:\_BOOMBACKUP\testdb.bak' 
WITH NOFORMAT, NOINIT,  
NAME = N'testdb-Log', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO



select * into k1 from kunden

BACKUP DATABASE [testdb] TO  
DISK = N'C:\_BOOMBACKUP\testdb.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT, 
 NAME = N'testdb-Vollständig Datenbank Sichern',
  SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


--Situation 1:

--letzte Sicherung ist ca 20min her
--und jetzt kommt aktuell eine Problem
--vor 5 min
--Restore bis vor 6 min

--Idee: jetzt T Sicherung, dann restore @10:54
--evtl Problem: evtl falsche Zeit und Daten seit 1064 sind zunächst weg
--Idee2 : DB unter anderen Namen restoren

--1054
--letzte Sicherung 1040... 1110
--T Sicherung jetzt (1110)
--Restore auf 1054
--aber es soll kein Datenverlust entstehen
--Die User müssen gekillt werden
--SPID > 50  kill 86 kill 85
--und keiner darf mehr auf die DB

--was wäre wenn ich wüsste..

--ein Backup, das eine weiter lesbare DB darstellt
--die sich nie ändert : Snapshot


-- Create the database snapshot
CREATE DATABASE NamedeinerDB ON
( NAME = <Database_Name, sysname, Database_Name>, FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Data\<Database_Name, sysname, Database_Name>_<Snapshot_Id,,Snapshot_ID>.ss' )
AS SNAPSHOT OF OrgDB;
GO


create database sn_testdb_1200 on
(name= testdb   , filename='c:\_sql\sn_testdb_1200.mdf' )
as snapshot of testdb

--was wenn
--Testdb 100 GB ---> D: (frei 10 GB)




use master
--keiner darf auf dem Snapshot sein und auch keiner auf 
--der OrgDB
--geht
-- D: (frei 1 GB)
--geht
---- D: (frei 1 MB)
--geht

--und dennoch wird eine 100GB Datei angelegt!!!!!
--sparse files
use master

restore database testdb
from database_snapshot='sn_testdb_1200'

--worin liegt der gravierende Vorteil
--des Snapshot

-->deutlich schneller, weil nur die Daten des Snapshot
--kopiert werden müssen
--man kann mehrfach snapshots haben

--Sicherung der Org DB möglich: ja
--Sicherung des Snapshot: hä? nee
--Restore des Snapshot: hääääää? siehe oben
--restore der OrgDB machen? Nö.. vorher snapshots




--plan für 15 GB
--DB: 15 GB
--Ausfallzeit: am besten gar nicht, max 15min
--Max Datenverlust: in Zeit...      am besten gar nicht
					--> 5 min

--Arbeitszeiten: Mo bis SO (24h)

--> alle 5min TLog
--> täglich   V ( 4 bis 5 min) --> R (6 min)
-->  D 	alle 15 oder 20 min		(alle paar 3 bis 4Ts)

-- V TTT D TTT D TTT D TTT  D


V: 6:00
T: 6:02
D: 7.24



select 15000/100


