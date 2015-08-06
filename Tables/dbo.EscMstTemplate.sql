SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EscMstTemplate] (
		[TemplateID]       [bigint] NOT NULL,
		[MemberID]         [bigint] NOT NULL,
		[ServiceID]        [int] NOT NULL,
		[TemplateName]     [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DcDtime]          [datetime] NOT NULL,
		[CreatedBy]        [bigint] NOT NULL,
		[TimeZone]         [varchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Second]
GO
ALTER TABLE [dbo].[EscMstTemplate] SET (LOCK_ESCALATION = TABLE)
GO
