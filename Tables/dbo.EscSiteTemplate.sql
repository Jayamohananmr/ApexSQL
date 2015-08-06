SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[EscSiteTemplate] (
		[SiteID]         [bigint] NOT NULL,
		[TemplateID]     [bigint] NOT NULL,
		[DcDtime]        [datetime] NOT NULL,
		[CreatedBy]      [bigint] NOT NULL,
		[ID]             [bigint] NOT NULL
) ON [Second]
GO
ALTER TABLE [dbo].[EscSiteTemplate] SET (LOCK_ESCALATION = TABLE)
GO
