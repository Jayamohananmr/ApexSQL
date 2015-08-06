SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EscSiteTimeZone] (
		[Siteid]              [bigint] NOT NULL,
		[EscTimeZoneCode]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Dcdtime]             [datetime] NOT NULL,
		[CreatedBy]           [bigint] NOT NULL,
		[ID]                  [bigint] NOT NULL
) ON [Second]
GO
ALTER TABLE [dbo].[EscSiteTimeZone] SET (LOCK_ESCALATION = TABLE)
GO
