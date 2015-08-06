SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EscMstTemplateDetails] (
		[TemplateID]        [bigint] NOT NULL,
		[EscalationDay]     [int] NOT NULL,
		[FromTime]          [bigint] NULL,
		[ToTime]            [bigint] NULL,
		[CategoryID]        [bigint] NOT NULL,
		[ActionID]          [bigint] NOT NULL,
		[Contact1]          [bigint] NULL,
		[Contact2]          [bigint] NULL,
		[Contact3]          [bigint] NULL,
		[Contact4]          [bigint] NULL,
		[Contact5]          [bigint] NULL,
		[EmailAlert]        [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]           [datetime] NOT NULL,
		[CreatedBy]         [bigint] NOT NULL,
		[ID]                [bigint] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[EscMstTemplateDetails] SET (LOCK_ESCALATION = TABLE)
GO
