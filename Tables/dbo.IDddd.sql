SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[IDddd] (
		[a]     [int] NULL,
		[b]     [int] IDENTITY(1, 1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IDddd] SET (LOCK_ESCALATION = TABLE)
GO