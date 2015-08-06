SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SessionAudit] (
		[SessionId]            [bigint] NOT NULL,
		[TTId]                 [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SessionEndTime]       [datetime] NULL,
		[SessionStartTime]     [datetime] NULL,
		[OSUserName]           [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UserId]               [int] NULL,
		[Product]              [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Notes]                [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ClientResName]        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]              [datetime] NULL,
		[TestID]               [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SessionAudit] SET (LOCK_ESCALATION = TABLE)
GO
