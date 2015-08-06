SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mst_DDConfig_Member] (
		[TemplateID]     [bigint] IDENTITY(1, 1) NOT NULL,
		[MemberID]       [bigint] NULL,
		[DDRCThld]       [bigint] NULL,
		[DDKAThld]       [bigint] NULL,
		[GroupType]      [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CreatedBy]      [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcdTime]        [datetime] NULL,
		[ModifiedBy]     [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ModifiedOn]     [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[Mst_DDConfig_Member]
	ADD
	CONSTRAINT [DF__Mst_DDCon__DcdTi__214BF109]
	DEFAULT (getdate()) FOR [DcdTime]
GO
CREATE CLUSTERED INDEX [idx_memb]
	ON [dbo].[Mst_DDConfig_Member] ([MemberID])
	ON [Second]
GO
ALTER TABLE [dbo].[Mst_DDConfig_Member] SET (LOCK_ESCALATION = TABLE)
GO
