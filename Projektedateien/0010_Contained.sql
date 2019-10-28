--Features

--Contained Database
--Eigenständige DB:
--was braucht eine DB , ist ab er nicht in DB gesp.
--Logins, Aufträge, temp Tabellen

--teilweise
--Logins zur DB 
--
EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

--jede DB ist zunächst keine ContDB

--ContDB in der DB aktiviert werden

USE [master]
GO
ALTER DATABASE [MUCDB] 
SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO
