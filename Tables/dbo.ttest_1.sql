SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ttest_1] (
		[a]     [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ttest_1] SET (LOCK_ESCALATION = TABLE)
GO
