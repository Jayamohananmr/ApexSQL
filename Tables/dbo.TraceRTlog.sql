SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraceRTlog] (
		[IP]         [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Regid]      [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Hop]        [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Detail]     [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TraceRTlog] SET (LOCK_ESCALATION = TABLE)
GO
