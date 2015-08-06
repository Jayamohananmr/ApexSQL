SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PubIPMon_ConfigStatus_History] (
		[PubIPRegID]      [bigint] NOT NULL,
		[PubIPAddrs]      [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IPStatus]        [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ErrCode]         [bigint] NULL,
		[ErrDesc]         [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TracertDesc]     [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcdTime]         [datetime] NULL,
		[UpDcdTime]       [datetime] NULL,
		[InsertedOn]      [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_ConfigStatus_History]
	ADD
	CONSTRAINT [DF__PubIPMon___Inser__67DE6983]
	DEFAULT (getdate()) FOR [InsertedOn]
GO
CREATE CLUSTERED INDEX [IX_RegID]
	ON [dbo].[PubIPMon_ConfigStatus_History] ([PubIPRegID])
	ON [Second]
GO
CREATE NONCLUSTERED INDEX [IX_Status]
	ON [dbo].[PubIPMon_ConfigStatus_History] ([IPStatus])
	ON [Second]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_ConfigStatus_History', 'COLUMN', N'DcdTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'IPAddress configured by partner from Portal', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_ConfigStatus_History', 'COLUMN', N'PubIPAddrs'
GO
EXEC sp_addextendedproperty N'MS_Description', N'PublicIP registration ID', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_ConfigStatus_History', 'COLUMN', N'PubIPRegID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Updated data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_ConfigStatus_History', 'COLUMN', N'UpDcdTime'
GO
ALTER TABLE [dbo].[PubIPMon_ConfigStatus_History] SET (LOCK_ESCALATION = TABLE)
GO
