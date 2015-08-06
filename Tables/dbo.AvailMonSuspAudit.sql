SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AvailMonSuspAudit] (
		[Regid]          [bigint] NOT NULL,
		[SuspTotime]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]        [datetime] NOT NULL
) ON [Second]
GO
ALTER TABLE [dbo].[AvailMonSuspAudit]
	ADD
	CONSTRAINT [DF_AvailMonSuspAudit_DcDtime]
	DEFAULT (getdate()) FOR [DcDtime]
GO
CREATE CLUSTERED INDEX [IX_Regid]
	ON [dbo].[AvailMonSuspAudit] ([Regid])
	ON [Second]
GO
ALTER TABLE [dbo].[AvailMonSuspAudit] SET (LOCK_ESCALATION = TABLE)
GO
