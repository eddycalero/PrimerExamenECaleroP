USE AdventureWorks2019
GO
--CrearDispositivo
EXEC sp_addumpdevice 'disk', 'AWDv_ECaleroP',
'C:\BackupTarea\AdventureWorks2019.bak';
GO

-- Informacion del dispositivo
EXEC sp_helpdevice 'AWDv_ECaleroP'
GO

-- Borrar el dispositivo
EXEC sp_dropdevice 'AWDv_ECaleroP'
GO

CREATE OR ALTER PROC AdventureWord_Backups_Full
AS
BEGIN 

-- Nombre para el backups de forma dinamica
DECLARE @NameBackupsFull NVARCHAR(100) ='AwDv_ECaleroP' + CONVERT(NVARCHAR(40), GETDATE(), 103) + '_Full'

--SELECT @NameBackupsFull
-- Modo Recovery Full
ALTER DATABASE AdventureWorks2019
SET RECOVERY FULL

BACKUP DATABASE AdventureWorks2019
TO AWDv_ECaleroP
WITH INIT, FORMAT, 
NAME = @NameBackupsFull,
DESCRIPTION  = 'AdventureWork2019_Backup_Full'
END

EXEC AdventureWord_Backups_Full 
GO

