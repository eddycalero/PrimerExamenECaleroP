
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO

-- Create a Database Mail profile  
EXECUTE msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'EddyJose',  
    @description = 'Perfil de Notificaciones administrador' ;  
GO

-- Grant access to the profile to the DBMailUsers role  
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
    @profile_name = 'EddyJose',  
    @principal_name = 'public',  
    @is_default = 1 ;
GO

-- Create a Database Mail account  
EXECUTE msdb.dbo.sysmail_add_account_sp  
    @account_name = 'EddyJoseHotmail',  
    @description = 'Correo de notificaciones',  
    @email_address = 'caleroeddy99@hotmail.com',  
    @display_name = 'Administrador',  
    @mailserver_name = 'smtp-mail.outlook.com',
    @port = 587,
    @enable_ssl = 1,
    @username = 'caleroeddy99@hotmail.com',
    @password = '' ;  
GO

use master 

-- Add the account to the profile  
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'EddyJose',  
    @account_name = 'EddyJoseHotmail',  
    @sequence_number =1 ;  
GO


SELECT * FROM msdb.dbo.sysmail_event_log;


USE AdventureWorks2019

select * from Production.ProductCategory

CREATE TRIGGER EnviarEmailses
ON Production.ProductCategory
AFTER INSERT, UPDATE, DELETE
AS
	 EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'EddyJose',
     @recipients = 'Williamjsg@gmail.com',
     @body = 'Estoy enviando Correo 9:56 AM 17/12/2022 y se actualiso la base de datos',
     @subject = 'Eddy Calero';

GO

