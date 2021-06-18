CREATE TABLE [dbo].[Products] (
    [Id]          SMALLINT        IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (200)   NOT NULL,
    [Description] VARCHAR (500)   NULL,
    [Price]       DECIMAL (18, 2) NOT NULL,
    [CreatedDate] DATETIME        NOT NULL,
    [CategoryId]  SMALLINT        NOT NULL,
    [StatusId]    TINYINT         CONSTRAINT [DF_Products_StatusId] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([Id]),
    CONSTRAINT [FK_Products_ProductStatus] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[ProductStatus] ([ProductStatusId])
);

