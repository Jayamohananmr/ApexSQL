SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RcDTime] (
		[RegID]       [bigint] NULL,
		[Dctime]      [datetime] NULL,
		[RcKey]       [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RcDtime]     [datetime] NULL,
		[Route]       [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RcDTime]
	ADD
	CONSTRAINT [DF_RcDTime_Dctime]
	DEFAULT (getdate()) FOR [Dctime]
GO
ALTER TABLE [dbo].[RcDTime]
	ADD
	CONSTRAINT [DF_RcDTime_Route]
	DEFAULT ((0)) FOR [Route]
GO
CREATE CLUSTERED INDEX [IX_RcDTime]
	ON [dbo].[RcDTime] ([RegID])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RcDTime] SET (LOCK_ESCALATION = TABLE)
GO
