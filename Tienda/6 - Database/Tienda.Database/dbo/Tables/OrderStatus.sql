CREATE TABLE [dbo].[OrderStatus] (
    [OrderStatusId] TINYINT      NOT NULL,
    [Description]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED ([OrderStatusId] ASC)
);

