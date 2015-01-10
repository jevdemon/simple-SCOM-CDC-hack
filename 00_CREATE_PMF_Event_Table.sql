USE [Northwind]
GO

/****** Object:  Table [dbo].[pmfEvent]    Script Date: 11/03/2010 12:33:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pmfEvent](
	[EventId] [int] NOT NULL,
	[EventSource] [varchar](20) NOT NULL,
	[Category] [varchar](20) NOT NULL,
	[EventTime] [datetime] NOT NULL,
	[Expiration] [datetime] NOT NULL,
	[AccountId] [varchar](20) NOT NULL,
	[AccountName] [varchar](20) NOT NULL,
	[AccountType] [varchar](20) NOT NULL,
	[ContactName] [varchar](50) NOT NULL,
	[EmailAddress] [varchar](20) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Keywords] [varchar](20) NOT NULL,
	[EventPKey] [int] IDENTITY(100,100) NOT NULL,
	[EventType] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EventPKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

