SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mst_DDConfig_History] (
		[RowID]          [bigint] IDENTITY(1, 1) NOT NULL,
		[TemplateID]     [bigint] NULL,
		[MemberID]       [bigint] NULL,
		[SiteID]         [bigint] NULL,
		[RegID]          [bigint] NULL,
		[DDRCThld]       [bigint] NULL,
		[DDKAThld]       [bigint] NULL,
		[GroupType]      [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CreatedBy]      [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcdTime]        [datetime] NULL,
		[ModifiedBy]     [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ModifiedOn]     [datetime] NULL,
		[InsertedOn]     [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[Mst_DDConfig_History]
	ADD
	CONSTRAINT [DF__Mst_DDCon__Inser__345EC57D]
	DEFAULT (getdate()) FOR [InsertedOn]
GO
CREATE NONCLUSTERED INDEX [idx_]
	ON [dbo].[Mst_DDConfig_History] ([GroupType], [TemplateID])
	ON [Second]
GO
CREATE CLUSTERED INDEX [idx_RowId]
	ON [dbo].[Mst_DDConfig_History] ([RowID])
	ON [Second]
GO
ALTER TABLE [dbo].[Mst_DDConfig_History] SET (LOCK_ESCALATION = TABLE)
GO
