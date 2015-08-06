SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mst_DDConfig_Regid] (
		[TemplateID]     [bigint] IDENTITY(1, 1) NOT NULL,
		[MemberID]       [bigint] NULL,
		[SiteID]         [bigint] NULL,
		[RegID]          [bigint] NULL,
		[DDRCThld]       [bigint] NULL,
		[DDKAThld]       [bigint] NULL,
		[GroupType]      [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CreatedBy]      [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcdTime]        [datetime] NULL,
		[ModifiedBy]     [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ModifiedOn]     [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[Mst_DDConfig_Regid]
	ADD
	CONSTRAINT [DF__Mst_DDCon__DcdTi__308E3499]
	DEFAULT (getdate()) FOR [DcdTime]
GO
ALTER TABLE [dbo].[Mst_DDConfig_Regid] SET (LOCK_ESCALATION = TABLE)
GO
