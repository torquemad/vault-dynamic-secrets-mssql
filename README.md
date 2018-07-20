# vault-dynamic-secrets-mssql
docker-composed mssql + vault example

sqlcmd commands:
docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>

show all logins
```
SELECT * from master.sys.sql_logins
GO
```
show all users
```
SELECT * from master.sys.sysusers
GO
```
show all open db connections (stored proc)
```
exec sp_who
GO
```

Useful MSSQL commands:
```
CREATE TABLE your_table( A INT)
SELECT * FROM your_table;

DECLARE @I INT=0
WHILE @I <100
BEGIN
	INSERT INTO your_table VALUES(@I)
	SET @I=@I+1
END

truncate table your_table;
```
