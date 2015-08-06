SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PubIPMon_ConfigSts_Cons] (
		[MemberID]        [bigint] NULL,
		[SiteID]          [bigint] NULL,
		[PubIPRegID]      [bigint] NULL,
		[PubIPAddrss]     [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ConditionID]     [bigint] NULL,
		[TaskRawID]       [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]         [datetime] NULL,
		[UpDcDtime]       [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_ConfigSts_Cons]
	ADD
	CONSTRAINT [DF__PubIPMon___DcDti__73501C2F]
	DEFAULT (getdate()) FOR [DcDtime]
GO
CREATE CLUSTERED INDEX [IX_RegID]
	ON [dbo].[PubIPMon_ConfigSts_Cons] ([PubIPRegID])
	ON [Second]
GO
ALTER TABLE [dbo].[PubIPMon_ConfigSts_Cons] SET (LOCK_ESCALATION = TABLE)
GO
