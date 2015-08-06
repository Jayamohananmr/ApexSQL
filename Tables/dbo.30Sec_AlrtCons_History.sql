SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[30Sec_AlrtCons_History] (
		[RowID]                 [bigint] IDENTITY(1, 1) NOT NULL,
		[AlrtID]                [bigint] NULL,
		[RegID]                 [bigint] NOT NULL,
		[TktID]                 [bigint] NULL,
		[DateTime]              [datetime] NULL,
		[AlertGroup]            [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ThresholdCounter]      [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DCDateTime]            [datetime] NULL,
		[MNDateTime]            [datetime] NULL,
		[Status]                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AddDetails]            [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ThValue]               [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[JobPostStatus]         [bit] NULL,
		[RCThldSec]             [bigint] NULL,
		[KAThldSec]             [bigint] NULL,
		[RCThldSec_OnClose]     [bigint] NULL,
		[KAThldSec_OnClose]     [bigint] NULL
) ON [Second]
GO
CREATE CLUSTERED INDEX [idx_RowID]
	ON [dbo].[30Sec_AlrtCons_History] ([RowID])
	ON [Second]
GO
ALTER TABLE [dbo].[30Sec_AlrtCons_History] SET (LOCK_ESCALATION = TABLE)
GO
