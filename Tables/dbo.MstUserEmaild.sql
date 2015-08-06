SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MstUserEmaild] (
		[ID]          [bigint] IDENTITY(1, 1) NOT NULL,
		[UserID]      [bigint] NULL,
		[Emailid]     [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]     [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstUserEmaild]
	ADD
	CONSTRAINT [PK_MstUserEmaild]
	PRIMARY KEY
	NONCLUSTERED
	([ID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstUserEmaild]
	ADD
	CONSTRAINT [DF_MstUserEmaild_DcDtime]
	DEFAULT (getdate()) FOR [DcDtime]
GO
CREATE CLUSTERED INDEX [IX_MstUserEmaild]
	ON [dbo].[MstUserEmaild] ([UserID])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstUserEmaild] SET (LOCK_ESCALATION = TABLE)
GO
