SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sec_AlrtConsBck] (
		[AlrtID]               [bigint] NULL,
		[RegID]                [bigint] NULL,
		[TktID]                [bigint] NULL,
		[DateTime]             [datetime] NULL,
		[AlertGroup]           [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ThresholdCounter]     [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DCDateTime]           [datetime] NULL,
		[MNDateTime]           [datetime] NULL,
		[Status]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AddDetails]           [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ThValue]              [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[JobPostStatus]        [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sec_AlrtConsBck] SET (LOCK_ESCALATION = TABLE)
GO
