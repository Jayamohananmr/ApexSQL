SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EscMstAction] (
		[ActionID]       [bigint] NOT NULL,
		[ActionDesc]     [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServiceID]      [int] NOT NULL,
		[DcDtime]        [datetime] NOT NULL,
		[CreatedBy]      [bigint] NOT NULL
) ON [Second]
GO
ALTER TABLE [dbo].[EscMstAction] SET (LOCK_ESCALATION = TABLE)
GO
