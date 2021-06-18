CREATE TABLE [dbo].[ProductStatus] (
    [ProductStatusId] TINYINT      NOT NULL,
    [Description]     VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ProductStatus] PRIMARY KEY CLUSTERED ([ProductStatusId] ASC)
);

