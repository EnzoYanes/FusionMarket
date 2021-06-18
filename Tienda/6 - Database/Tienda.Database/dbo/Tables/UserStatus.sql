CREATE TABLE [dbo].[UserStatus] (
    [UserStatusId] TINYINT      NOT NULL,
    [Description]  VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_UserStatus] PRIMARY KEY CLUSTERED ([UserStatusId] ASC)
);

