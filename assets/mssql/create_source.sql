CREATE DATABASE TestDB;
GO

USE TestDB;
GO

CREATE TABLE Accounts (id INT, name NVARCHAR(50), phone NVARCHAR(16));
GO

EXEC sys.sp_cdc_enable_db;
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'Accounts',
@role_name     = NULL;
GO