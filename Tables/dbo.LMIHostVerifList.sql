SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[LMIHostVerifList] (
		[Regid]         [bigint] NOT NULL,
		[lmiHostid]     [bigint] NOT NULL,
		[Regtype]       [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DcDtime]       [datetime] NOT NULL,
		[erCode]        [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Second]
GO
CREATE CLUSTERED INDEX [IX_LMIHostVerifList]
	ON [dbo].[LMIHostVerifList] ([Regid])
	WITH ( FILLFACTOR = 80)
	ON [Second]
GO
CREATE NONCLUSTERED INDEX [IX_LMIHostVerifList_1]
	ON [dbo].[LMIHostVerifList] ([lmiHostid])
	WITH ( FILLFACTOR = 80)
	ON [Second]
GO
ALTER TABLE [dbo].[LMIHostVerifList] SET (LOCK_ESCALATION = TABLE)
GO
