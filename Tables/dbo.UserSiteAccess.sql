SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserSiteAccess] (
		[SiteID]      [bigint] NOT NULL,
		[UserId]      [bigint] NOT NULL,
		[DcDtime]     [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserSiteAccess]
	ADD
	CONSTRAINT [PK_UserSiteAccess]
	PRIMARY KEY
	CLUSTERED
	([SiteID], [UserId])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserSiteAccess]
	ADD
	CONSTRAINT [DF__USERSITEA__DcDti__4222D4EF]
	DEFAULT (getdate()) FOR [DcDtime]
GO
ALTER TABLE [dbo].[UserSiteAccess] SET (LOCK_ESCALATION = TABLE)
GO
