USE [AdventureWorks2019]
GO

INSERT INTO [Production].[ProductCategory]
           ([Name]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
          ( 'nUEVO PRODUCTO',
           NEWID(),
           GETDATE())
GO


