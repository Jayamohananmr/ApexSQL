SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dpma1] (
		[MemberName]           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SiteName]             [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ResourceName]         [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OS]                   [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Regid]                [bigint] NOT NULL,
		[CurrentPort]          [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[InstallBuild]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LicenseType]          [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProductBuild]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProductType]          [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProductVersion]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[InstalledVersion]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LicenseInfo]          [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[HomeSite]             [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumHostId]            [bigint] NULL,
		[OSLMI]                [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OSSpec]               [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TimeZoneIndex]        [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DCDtime]              [datetime] NOT NULL,
		[PLicenseType]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLicenseID]           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PProductType]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIssueReason]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Parsed]               [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[dpma1] SET (LOCK_ESCALATION = TABLE)
GO
