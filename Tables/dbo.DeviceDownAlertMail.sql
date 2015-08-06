SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeviceDownAlertMail] (
		[Regid]         [bigint] NOT NULL,
		[SiteFrom]      [bigint] NOT NULL,
		[SiteTo]        [bigint] NOT NULL,
		[Action]        [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Subject]       [varchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Body]          [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Dcdtime]       [datetime] NOT NULL,
		[Mailed]        [int] NOT NULL,
		[SusToTime]     [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeviceDownAlertMail]
	ADD
	CONSTRAINT [DF_DeviceDownAlertMail_Dcdtime]
	DEFAULT (getdate()) FOR [Dcdtime]
GO
ALTER TABLE [dbo].[DeviceDownAlertMail]
	ADD
	CONSTRAINT [DF_DeviceDownAlertMail_Mailed]
	DEFAULT ((0)) FOR [Mailed]
GO
CREATE CLUSTERED INDEX [IX_DeviceDownAlertMail]
	ON [dbo].[DeviceDownAlertMail] ([Regid])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DeviceDownAlertMail_1]
	ON [dbo].[DeviceDownAlertMail] ([SiteFrom])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DeviceDownAlertMail_2]
	ON [dbo].[DeviceDownAlertMail] ([SiteTo])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeviceDownAlertMail] SET (LOCK_ESCALATION = TABLE)
GO
