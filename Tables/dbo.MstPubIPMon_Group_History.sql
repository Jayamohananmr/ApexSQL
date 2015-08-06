SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MstPubIPMon_Group_History] (
		[GrpID]          [bigint] NULL,
		[MemberID]       [bigint] NULL,
		[SiteID]         [bigint] NULL,
		[XmlStr]         [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CreatedBy]      [bigint] NULL,
		[UpdatedBy]      [bigint] NULL,
		[DcdTime]        [datetime] NULL,
		[UpDcdTime]      [datetime] NULL,
		[InsertedOn]     [datetime] NULL,
		[IsEnabled]      [bit] NULL,
		[IsMGMTUser]     [bit] NULL,
		[Reason]         [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Second] TEXTIMAGE_ON [Second]
GO
ALTER TABLE [dbo].[MstPubIPMon_Group_History]
	ADD
	CONSTRAINT [DF_InsertedOn]
	DEFAULT (getdate()) FOR [InsertedOn]
GO
CREATE CLUSTERED INDEX [IX_GrpID]
	ON [dbo].[MstPubIPMon_Group_History] ([GrpID])
	ON [Second]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Email Id of logged in user', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'CreatedBy'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Data center time', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'DcdTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Group IP', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'GrpID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time when data moved into history', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'InsertedOn'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Member ID', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'MemberID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Site ID', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'SiteID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Email Id of user who have modified entry', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'UpdatedBy'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Updated data center time', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'UpDcdTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'All Configured IP''s comes in a form of XML', 'SCHEMA', N'dbo', 'TABLE', N'MstPubIPMon_Group_History', 'COLUMN', N'XmlStr'
GO
ALTER TABLE [dbo].[MstPubIPMon_Group_History] SET (LOCK_ESCALATION = TABLE)
GO
