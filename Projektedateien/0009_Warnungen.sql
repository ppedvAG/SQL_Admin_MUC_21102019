USE [master]
GO
CREATE LOGIN [Tom] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Tom] FOR LOGIN [Tom]
GO
USE [Northwind]
GO
ALTER USER [Tom] WITH DEFAULT_SCHEMA=[IT]
GO
USE [Northwind]
GO
ALTER ROLE [ITGruppe] ADD MEMBER [Tom]
GO


select * from sysloginsss

--Schweregrade
--9.... verpiss dich....
--11.... verpiss dich


select * from sysmessages
--15,, trottel
--16.. omg du Trottel..
--17... hmmm
--19...ahhhhh
--21...arghhhh
--23..verfl Ka**
--25..KLaus SH Dom***



