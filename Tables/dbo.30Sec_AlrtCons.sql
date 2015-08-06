SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[30Sec_AlrtCons] (
		[AlrtID]               [bigint] IDENTITY(1, 1) NOT NULL,
		[RegID]                [bigint] NOT NULL,
		[TktID]                [bigint] NULL,
		[DateTime]             [datetime] NULL,
		[AlertGroup]           [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ThresholdCounter]     [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DCDateTime]           [datetime] NULL,
		[MNDateTime]           [datetime] NULL,
		[Status]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AddDetails]           [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ThValue]              [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[JobPostStatus]        [bit] NULL,
		[RCThldSec]            [bigint] NULL,
		[KAThldSec]            [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[30Sec_AlrtCons]
	ADD
	CONSTRAINT [PK_SMAConsoleAlrtStatus]
	PRIMARY KEY
	NONCLUSTERED
	([AlrtID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SMAConsoleAlrtStatus]
	ON [dbo].[30Sec_AlrtCons] ([RegID])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SMAConsoleAlrtStatus_1]
	ON [dbo].[30Sec_AlrtCons] ([ThresholdCounter])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'test', 'SCHEMA', N'dbo', 'TABLE', N'30Sec_AlrtCons', 'COLUMN', N'AlrtID'
GO
ALTER TABLE [dbo].[30Sec_AlrtCons] SET (LOCK_ESCALATION = TABLE)
GO
