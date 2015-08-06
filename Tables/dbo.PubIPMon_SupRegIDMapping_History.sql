SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PubIPMon_SupRegIDMapping_History] (
		[GrpID]          [bigint] NULL,
		[SupRegID]       [bigint] NULL,
		[AddedBy]        [bigint] NULL,
		[DcdTime]        [datetime] NULL,
		[InsertedOn]     [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_SupRegIDMapping_History]
	ADD
	CONSTRAINT [DF_PubIPMon_SupRegIDMapping_History_InsertedOn]
	DEFAULT (getdate()) FOR [InsertedOn]
GO
CREATE CLUSTERED INDEX [IX_GrpID]
	ON [dbo].[PubIPMon_SupRegIDMapping_History] ([GrpID])
	ON [Second]
GO
CREATE NONCLUSTERED INDEX [IX_RegID]
	ON [dbo].[PubIPMon_SupRegIDMapping_History] ([SupRegID])
	ON [Second]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Email Id of logged in user', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping_History', 'COLUMN', N'AddedBy'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Data center time', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping_History', 'COLUMN', N'DcdTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Group IP', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping_History', 'COLUMN', N'GrpID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time when data moved into history', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping_History', 'COLUMN', N'InsertedOn'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Agents added by from Portal for Suppression', 'SCHEMA', N'dbo', 'TABLE', N'PubIPMon_SupRegIDMapping_History', 'COLUMN', N'SupRegID'
GO
ALTER TABLE [dbo].[PubIPMon_SupRegIDMapping_History] SET (LOCK_ESCALATION = TABLE)
GO
