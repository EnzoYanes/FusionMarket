CREATE PROCEDURE [dbo].[Users_AddUser]
	@Name varchar(50),
	@Surname varchar(50),
    @DocumentNumber varchar(25),
    @Username varchar(50),
    @Password varchar(50)
AS
	INSERT INTO Users ([Name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId])
    VALUES (@Name, @Surname, @DocumentNumber, GETDATE(), @Username, @Password, 1)
RETURN 0


/*
[Id]             SMALLINT     IDENTITY (1, 1) NOT NULL,
    [Name]           VARCHAR (50) NOT NULL,
    [Surname]        VARCHAR (50) NOT NULL,
    [DocumentNumber] VARCHAR (25) NOT NULL,
    [CreatedDate]    DATETIME     NOT NULL,
    [Username]       VARCHAR (50) NOT NULL,
    [Password]       VARCHAR (50) NOT NULL,
    [StatusId]
*/