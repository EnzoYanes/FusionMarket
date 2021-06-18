CREATE TABLE [dbo].[OrderLines] (
    [OrderId]   INT             NOT NULL,
    [ProductId] SMALLINT        NOT NULL,
    [Quantity]  SMALLINT        NOT NULL,
    [UnitPrice] DECIMAL (18, 2) CONSTRAINT [DF_OrderLines_UnitPrice] DEFAULT ((0)) NOT NULL,
    [Subtotal]  AS              ([Quantity]*[UnitPrice]),
    CONSTRAINT [PK_OrderLine] PRIMARY KEY CLUSTERED ([OrderId] ASC, [ProductId] ASC),
    CONSTRAINT [FK_OrderLine_Orders] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([Id]),
    CONSTRAINT [FK_OrderLine_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([Id])
);

