SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mst_DDConfig_Site] (
		[TemplateID]     [bigint] IDENTITY(1, 1) NOT NULL,
		[MemberID]       [bigint] NULL,
		[SiteID]         [bigint] NULL,
		[DDRCThld]       [bigint] NULL,
		[DDKAThld]       [bigint] NULL,
		[GroupType]      [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CreatedBy]      [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcdTime]        [datetime] NULL,
		[ModifiedBy]     [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ModifiedOn]     [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[Mst_DDConfig_Site]
	ADD
	CONSTRAINT [DF__Mst_DDCon__DcdTi__1D7B6025]
	DEFAULT (getdate()) FOR [DcdTime]
GO
CREATE NONCLUSTERED INDEX [idx_mebsite]
	ON [dbo].[Mst_DDConfig_Site] ([MemberID], [SiteID])
	ON [Second]
GO
CREATE CLUSTERED INDEX [idx_tempid]
	ON [dbo].[Mst_DDConfig_Site] ([TemplateID])
	ON [Second]
GO
ALTER TABLE [dbo].[Mst_DDConfig_Site] SET (LOCK_ESCALATION = TABLE)
GO
