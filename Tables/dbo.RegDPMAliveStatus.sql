SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegDPMAliveStatus] (
		[RegId]           [bigint] NOT NULL,
		[DCTime]          [datetime] NULL,
		[RegStatus]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SysId]           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SysIdStatus]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SEString]        [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SEExeIds]        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SECount]         [numeric](18, 0) NULL,
		[Route]           [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[routeIP]         [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UnInstTKID]      [bigint] NULL,
		[UninstDate]      [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[RegDPMAliveStatus]
	ADD
	CONSTRAINT [DF_RegDPMAliveStatus_RegStatus]
	DEFAULT ('Enabled') FOR [RegStatus]
GO
ALTER TABLE [dbo].[RegDPMAliveStatus]
	ADD
	CONSTRAINT [DF_RegDPMAliveStatus_SECount]
	DEFAULT ((0)) FOR [SECount]
GO
CREATE CLUSTERED INDEX [IX_RegDPMAliveStatus]
	ON [dbo].[RegDPMAliveStatus] ([RegId])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RegDPMAliveStatus] SET (LOCK_ESCALATION = TABLE)
GO
