SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MstEscCategory] (
		[CatMastID]        [bigint] NOT NULL,
		[CategoryName]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]          [datetime] NOT NULL
) ON [Second]
GO
ALTER TABLE [dbo].[MstEscCategory] SET (LOCK_ESCALATION = TABLE)
GO
