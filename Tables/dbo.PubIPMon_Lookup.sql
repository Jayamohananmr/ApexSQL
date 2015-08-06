SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PubIPMon_Lookup] (
		[GrpID]           [bigint] NULL,
		[PubIPRegID]      [bigint] NULL,
		[PubIPAddrs]      [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ActionTkn]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsProcessed]     [bit] NULL,
		[DcdTime]         [datetime] NULL,
		[UpDcdTime]       [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_Lookup]
	ADD
	CONSTRAINT [DF_PubIPMon_Lookup_DcdTime]
	DEFAULT (getdate()) FOR [DcdTime]
GO
ALTER TABLE [dbo].[PubIPMon_Lookup]
	ADD
	CONSTRAINT [IX_IsProcessed]
	DEFAULT ((0)) FOR [IsProcessed]
GO
CREATE CLUSTERED INDEX [IX_GrpID]
	ON [dbo].[PubIPMon_Lookup] ([GrpID])
	ON [Second]
GO
CREATE NONCLUSTERED INDEX [IX_RegID]
	ON [dbo].[PubIPMon_Lookup] ([PubIPRegID])
	ON [Second]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Action taken from Portal for IP''s (Added/ Removed)', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Lookup', 'COLUMN', N'ActionTkn'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Lookup', 'COLUMN', N'DcdTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Group IP', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Lookup', 'COLUMN', N'GrpID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'To check data processed or not', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Lookup', 'COLUMN', N'IsProcessed'
GO
EXEC sp_addextendedproperty N'MS_Description', N'IPAddress configured by partner from Portal', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Lookup', 'COLUMN', N'PubIPAddrs'
GO
EXEC sp_addextendedproperty N'MS_Description', N'PublicIP registration ID', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Lookup', 'COLUMN', N'PubIPRegID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Updated data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_Lookup', 'COLUMN', N'UpDcdTime'
GO
ALTER TABLE [dbo].[PubIPMon_Lookup] SET (LOCK_ESCALATION = TABLE)
GO
