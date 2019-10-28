Prozesse der User spid > 50

--sysprocesses = Aktivitätsmonitor

select * from sysprocesses where dbid = db_id('mucdb')
--102

kill 61


--braucht man zb...
--DB in Einzelbenutzermodus setzen...


ALTER DATABASE testdb SET  MULTI_USER WITH NO_WAIT
GO





USE [master]
GO
ALTER DATABASE [MUCDB] SET  SINGLE_USER WITH NO_WAIT
GO


USE [master]
GO
ALTER DATABASE [MUCDB] SET  MULTI_USER WITH NO_WAIT
GO
