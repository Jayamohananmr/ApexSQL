SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalConfig_Site] (
		[SiteId]                      [bigint] NOT NULL,
		[DeskTopDeployID]             [smallint] NULL,
		[DesktopSch_time]             [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServerDeployID]              [smallint] NULL,
		[ServerTill_Time]             [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServerWeekDays]              [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServerSch_Time]              [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DeskTopTill_Time]            [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pri_AC_Holder_UID]           [bigint] NULL,
		[Escalation1_UID]             [bigint] NULL,
		[Escalation2_UID]             [bigint] NULL,
		[Escalation3_UID]             [bigint] NULL,
		[BaseMonConfig1]              [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BaseMonConfig2]              [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BaseMonConfig3]              [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DeskTopAutoType]             [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DeskTopAutoTime]             [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServerAutoType]              [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RestartServer]               [bit] NULL,
		[MSMA_DL_URL]                 [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RSMA_DL_URL]                 [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DPMA_DL_URL]                 [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SetUpNotify]                 [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Message]                     [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]                     [datetime] NULL,
		[BusinessHR_Fromtime]         [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BusinessHR_ToTime]           [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NON_BusinessHR_Fromtime]     [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NON_BusinessHR_Totime]       [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NON_BusinessHR_Wkdys]        [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BusinessHR_Wkdys]            [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GlobalConfig_Site]
	ADD
	CONSTRAINT [PK_GlobalConfig_site]
	PRIMARY KEY
	CLUSTERED
	([SiteId])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[GlobalConfig_Site]
	ADD
	CONSTRAINT [DF__GLOBALCON__DcDti__412EB0B6]
	DEFAULT (getdate()) FOR [DcDtime]
GO
ALTER TABLE [dbo].[GlobalConfig_Site] SET (LOCK_ESCALATION = TABLE)
GO
