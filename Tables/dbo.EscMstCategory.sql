SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EscMstCategory] (
		[CategoryID]       [bigint] NOT NULL,
		[CategoryDesc]     [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServiceID]        [int] NOT NULL,
		[DcDtime]          [datetime] NOT NULL,
		[CreatedBy]        [bigint] NOT NULL,
		[Note]             [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Second] TEXTIMAGE_ON [Second]
GO
ALTER TABLE [dbo].[EscMstCategory] SET (LOCK_ESCALATION = TABLE)
GO
