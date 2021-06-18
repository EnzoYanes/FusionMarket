CREATE TABLE [dbo].[Categories] (
    [Id]          SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([Id] ASC)
);



