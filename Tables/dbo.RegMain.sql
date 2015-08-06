SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegMain] (
		[MemberCode]          [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MemberID]            [bigint] NULL,
		[SiteId]              [bigint] NULL,
		[SiteCode]            [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SiteSubCode]         [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GUID]                [varchar](57) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ResourceName]        [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ResType]             [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RegId]               [bigint] NOT NULL,
		[ParentID]            [bigint] NULL,
		[RegType]             [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResFriendlyName]     [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResMonStatus]        [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OS]                  [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OSVersion]           [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ExcludePatch]        [bit] NULL,
		[ResMonEnabled]       [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IPAddresses]         [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CreatedON]           [datetime] NULL,
		[TKTID]               [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RegMain]
	ADD
	CONSTRAINT [PK_RegMain]
	PRIMARY KEY
	CLUSTERED
	([RegId])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RegMain]
	ADD
	CONSTRAINT [DF_RegMain_CreatedON]
	DEFAULT (getdate()) FOR [CreatedON]
GO
ALTER TABLE [dbo].[RegMain]
	ADD
	CONSTRAINT [DF_RegMain_ExcludePatch]
	DEFAULT ((0)) FOR [ExcludePatch]
GO
ALTER TABLE [dbo].[RegMain]
	ADD
	CONSTRAINT [DF_RegMain_ResMonEnabled]
	DEFAULT ((1)) FOR [ResMonEnabled]
GO
ALTER TABLE [dbo].[RegMain]
	ADD
	CONSTRAINT [DF_RegMain_ResMonStatus]
	DEFAULT ((1)) FOR [ResMonStatus]
GO
CREATE NONCLUSTERED INDEX [IX_RegMain]
	ON [dbo].[RegMain] ([MemberID])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RegMain_1]
	ON [dbo].[RegMain] ([ResourceName])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RegMain_2]
	ON [dbo].[RegMain] ([SiteId])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RegMain] SET (LOCK_ESCALATION = TABLE)
GO
