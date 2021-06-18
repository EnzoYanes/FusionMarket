CREATE TABLE [dbo].[Orders] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [BillingNumber] VARCHAR (100) NOT NULL,
    [CreatedDate]   DATETIME      CONSTRAINT [DF_Orders_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UserId]        SMALLINT      NOT NULL,
    [StatusId]      TINYINT       CONSTRAINT [DF_Orders_StatusId] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[OrderStatus] ([OrderStatusId]),
    CONSTRAINT [FK_Orders_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id])
);

