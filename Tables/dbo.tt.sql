SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[tt] (
		[a]     [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tt] SET (LOCK_ESCALATION = TABLE)
GO
