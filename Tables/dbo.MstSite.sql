SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MstSite] (
		[SiteId]                     [bigint] NOT NULL,
		[MemberId]                   [bigint] NOT NULL,
		[SiteName]                   [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Sitecode]                   [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Sitesubcode]                [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SiteAddress]                [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EscAccGrpID]                [bigint] NULL,
		[CreationDt]                 [datetime] NULL,
		[TimeZone]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CreationUserId]             [bigint] NULL,
		[MSMA]                       [bit] NULL,
		[RSMA]                       [bit] NULL,
		[DPMA]                       [bit] NULL,
		[RGCA]                       [bit] NULL,
		[ServiceId_Server]           [int] NULL,
		[ServiceId_Desktop]          [int] NULL,
		[HelpDeskSvc]                [tinyint] NULL,
		[HelpStartON]                [datetime] NULL,
		[HelpEndON]                  [datetime] NULL,
		[IsEnabled]                  [bit] NULL,
		[Desk_AllowPassCode]         [bit] NULL,
		[Desk_PassCode]              [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Desk_UnAttendBOControl]     [bit] NULL,
		[Desk_BOSupport]             [bit] NULL,
		[Svr_AllowPassCode]          [bit] NULL,
		[Svr_PassCode]               [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Svr_UnAttendBOControl]      [bit] NULL,
		[Svr_BOSupport]              [bit] NULL,
		[TimeBlock]                  [smallint] NULL,
		[Proxy]                      [bit] NULL,
		[Usr_Name]                   [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Password]                   [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PortNo]                     [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProxyIP]                    [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DisabledOn]                 [datetime] NULL,
		[IsBDROnly]                  [bit] NULL,
		[IsProActive]                [bit] NULL,
		[BDRREMAccess]               [bit] NULL,
		[HelpDeskSupportLevel]       [int] NULL,
		[SDEval]                     [int] NULL,
		[SDEvalStartOn]              [datetime] NULL,
		[SDEvalEndOn]                [datetime] NULL,
		[SiteAddress2]               [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SiteCity]                   [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SiteState]                  [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SiteCountry]                [bigint] NULL,
		[SitePostalCode]             [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EndClientDomain]            [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [PK_OrgMaster]
	PRIMARY KEY
	CLUSTERED
	([SiteId])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [DF__mstsite__BDRREMA__07C12930]
	DEFAULT ((1)) FOR [BDRREMAccess]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [DF__MSTSITE__IsBDROn__06CD04F7]
	DEFAULT ((0)) FOR [IsBDROnly]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [DF__MstSite__IsEnabl__00200768]
	DEFAULT ((1)) FOR [IsEnabled]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [DF__MSTSITE__IsProAc__1F98B2C1]
	DEFAULT ((0)) FOR [IsProActive]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [DF__MstSite__SDEval__00DF2177]
	DEFAULT ((0)) FOR [SDEval]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [DF_MstSite_HelpDeskSvc]
	DEFAULT ((0)) FOR [HelpDeskSvc]
GO
ALTER TABLE [dbo].[MstSite]
	ADD
	CONSTRAINT [DF_OrgMaster_CreationDt]
	DEFAULT (getdate()) FOR [CreationDt]
GO
CREATE NONCLUSTERED INDEX [IX_MstSite]
	ON [dbo].[MstSite] ([SiteName])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_MstSite_2]
	ON [dbo].[MstSite] ([MemberId])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstSite] SET (LOCK_ESCALATION = TABLE)
GO
