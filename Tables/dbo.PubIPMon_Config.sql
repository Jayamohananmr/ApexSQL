SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PubIPMon_Config] (
		[MemberID]       [bigint] NOT NULL,
		[SiteID]         [bigint] NOT NULL,
		[GrpID]          [bigint] NOT NULL,
		[PubIPRegID]     [bigint] NOT NULL,
		[PubIPAddrs]     [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FrndlyName]     [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SetAlert]       [bit] NULL,
		[DcdTime]        [datetime] NULL,
		[UpDcdTime]      [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_Config]
	ADD
	CONSTRAINT [DF_DcdTime]
	DEFAULT (getdate()) FOR [DcdTime]
GO
CREATE NONCLUSTERED INDEX [IX_GrpID]
	ON [dbo].[PubIPMon_Config] ([GrpID])
	ON [Second]
GO
CREATE CLUSTERED INDEX [IX_RegID]
	ON [dbo].[PubIPMon_Config] ([PubIPRegID])
	ON [Second]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'DcdTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Friendly name of IP', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'FrndlyName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Group IP', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'GrpID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Member ID', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'MemberID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'IPAddress configured by partner from Portal', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'PubIPAddrs'
GO
EXEC sp_addextendedproperty N'MS_Description', N'PublicIP registration ID', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'PubIPRegID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'To check the alert is configured or not', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'SetAlert'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Site ID', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'SiteID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Updated data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Config', 'COLUMN', N'UpDcdTime'
GO
ALTER TABLE [dbo].[PubIPMon_Config] SET (LOCK_ESCALATION = TABLE)
GO
