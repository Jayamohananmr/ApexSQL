SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HTTPSTunnel_AlrtCons] (
		[AlrtID]               [bigint] IDENTITY(1, 1) NOT NULL,
		[RegID]                [bigint] NOT NULL,
		[TktID]                [bigint] NOT NULL,
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
ALTER TABLE [dbo].[HTTPSTunnel_AlrtCons]
	ADD
	CONSTRAINT [PK_HTTPSTunnel_AlrtCons]
	PRIMARY KEY
	NONCLUSTERED
	([TktID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ConsoleAdlrt1]
	ON [dbo].[HTTPSTunnel_AlrtCons] ([ThresholdCounter])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_ConsoleAlrt]
	ON [dbo].[HTTPSTunnel_AlrtCons] ([RegID])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [PK_ConsoleAlrt1]
	ON [dbo].[HTTPSTunnel_AlrtCons] ([AlrtID])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[HTTPSTunnel_AlrtCons] SET (LOCK_ESCALATION = TABLE)
GO
