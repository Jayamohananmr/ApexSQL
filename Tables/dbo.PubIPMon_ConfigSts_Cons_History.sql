SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PubIPMon_ConfigSts_Cons_History] (
		[MemberID]        [bigint] NULL,
		[SiteID]          [bigint] NULL,
		[PubIPRegID]      [bigint] NULL,
		[PubIPAddrss]     [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ConditionID]     [bigint] NULL,
		[TaskRawID]       [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]         [datetime] NULL,
		[UpDcDtime]       [datetime] NULL,
		[InsertedOn]      [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_ConfigSts_Cons_History]
	ADD
	CONSTRAINT [DF__PubIPMon___Inser__753864A1]
	DEFAULT (getdate()) FOR [InsertedOn]
GO
CREATE CLUSTERED INDEX [IX_RegID]
	ON [dbo].[PubIPMon_ConfigSts_Cons_History] ([PubIPRegID])
	ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_ConfigSts_Cons_History] SET (LOCK_ESCALATION = TABLE)
GO
