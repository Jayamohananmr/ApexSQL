SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PubIPMon_SupRegIDMapping] (
		[GrpID]        [bigint] NULL,
		[SupRegID]     [bigint] NULL,
		[AddedBy]      [bigint] NULL,
		[DcdTime]      [datetime] NULL,
		[ID]           [bigint] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_SupRegIDMapping]
	ADD
	CONSTRAINT [DF_PubIPMon_SupRegIDMapping_DcdTime]
	DEFAULT (getdate()) FOR [DcdTime]
GO
CREATE NONCLUSTERED INDEX [IX_GrpID]
	ON [dbo].[PubIPMon_SupRegIDMapping] ([GrpID])
	ON [Second]
GO
CREATE CLUSTERED INDEX [IX_ID]
	ON [dbo].[PubIPMon_SupRegIDMapping] ([ID])
	ON [Second]
GO
CREATE NONCLUSTERED INDEX [IX_RegID]
	ON [dbo].[PubIPMon_SupRegIDMapping] ([SupRegID])
	ON [Second]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Email Id of logged in user', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping', 'COLUMN', N'AddedBy'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping', 'COLUMN', N'DcdTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Group IP', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping', 'COLUMN', N'GrpID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Agents added by from Portal for Suppression', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping', 'COLUMN', N'SupRegID'
GO
ALTER TABLE [dbo].[PubIPMon_SupRegIDMapping] SET (LOCK_ESCALATION = TABLE)
GO
