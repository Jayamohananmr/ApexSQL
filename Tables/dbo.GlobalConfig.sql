SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalConfig] (
		[MemberCode]               [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SiteCode]                 [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SiteSubCode]              [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GUID]                     [varchar](57) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ResourceName]             [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ResFriendlyName]          [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResType]                  [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RegId]                    [bigint] NULL,
		[ParentID]                 [bigint] NULL,
		[ResAddedBy]               [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResFromTime]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResToTime]                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResDays]                  [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResMSDomain]              [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResMSRemoteLocal]         [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResPOSDeviceType]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResPOSConnType]           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResPOSPrompt]             [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResPOSPort]               [int] NULL,
		[ResPOSTimeout]            [int] NULL,
		[ResSNMPDeviceType]        [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResSNMPVer]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResSNMPCommunity]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResSNMPRetries]           [int] NULL,
		[ResSNMPTimeout]           [int] NULL,
		[ResAddedDate]             [datetime] NULL,
		[ResAddStatus]             [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResStatusDate]            [datetime] NULL,
		[ResAddFailAckBy]          [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RegType]                  [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pri_AC_Holder]            [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TimeBlock]                [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Escalation1_EmailId]      [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Escalation2_EmailId1]     [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Escalation3_EmailId2]     [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BaseMonConfig1]           [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BaseMonConfig2]           [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BaseMonConfig3]           [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MemberId]                 [bigint] NULL,
		[SiteId]                   [bigint] NULL,
		[PingPackets]              [bigint] NULL,
		[PingTimeout]              [bigint] NULL,
		[PingCycleCnt]             [bigint] NULL,
		[PortTimeout]              [bigint] NULL,
		[PerformancecycleCnt]      [bigint] NULL,
		[ResUserName]              [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]                  [datetime] NULL,
		[ID]                       [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GlobalConfig]
	ADD
	CONSTRAINT [DF__GLOBALCON__DcDti__403A8C7D]
	DEFAULT (getdate()) FOR [DcDtime]
GO
CREATE NONCLUSTERED INDEX [IX_GlobalConfig]
	ON [dbo].[GlobalConfig] ([MemberCode])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_GlobalConfig_1]
	ON [dbo].[GlobalConfig] ([RegId])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_GlobalConfig_2]
	ON [dbo].[GlobalConfig] ([SiteCode])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_GlobalConfig_3]
	ON [dbo].[GlobalConfig] ([ParentID])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[GlobalConfig] SET (LOCK_ESCALATION = TABLE)
GO
