SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MstUser] (
		[UserID]                     [bigint] NOT NULL,
		[MemberId]                   [bigint] NOT NULL,
		[FName]                      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EmailID]                    [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OldPWD]                     [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Designation]                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsEnabled]                  [bit] NOT NULL,
		[IsAdmin]                    [bit] NOT NULL,
		[IsRBAC]                     [bit] NOT NULL,
		[IsAgentStatus]              [bit] NOT NULL,
		[IsBilling]                  [bit] NOT NULL,
		[Address]                    [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[City]                       [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZipCode]                    [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TelNo]                      [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MobileNo]                   [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Extension]                  [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SmsAlert]                   [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsAllowRemote]              [bit] NULL,
		[IsNOCUser]                  [bit] NOT NULL,
		[IsActive]                   [bit] NULL,
		[ActivedOn]                  [datetime] NULL,
		[DcDtime]                    [datetime] NULL,
		[PassExpDate]                [datetime] NULL,
		[IsSuperUser]                [bit] NULL,
		[PrimExt]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ISADMINPRIVILEGE]           [int] NULL,
		[SMSMobileNo]                [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SMSProvider]                [int] NULL,
		[SMSProviderEmail]           [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SendSMS]                    [bit] NULL,
		[IsTwFactAuthentication]     [bit] NULL,
		[TwFactProviderID]           [int] NULL,
		[TwFactEmailID]              [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AuthAnvilUserName]          [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AuthAnvilTokenID]           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AuthAnvilSiteID]            [int] NULL,
		[AuthAnvilSASUrl]            [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AuthAnvilTokenTypeID]       [int] NULL,
		[PWD]                        [varbinary](2000) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstUser]
	ADD
	CONSTRAINT [PK_UserMaster]
	PRIMARY KEY
	CLUSTERED
	([UserID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstUser]
	ADD
	CONSTRAINT [DF__MSTUSER__DcDtime__693CA210]
	DEFAULT (getdate()) FOR [DcDtime]
GO
ALTER TABLE [dbo].[MstUser]
	ADD
	CONSTRAINT [DF__Mstuser__IsSuper__282DF8C2]
	DEFAULT ((0)) FOR [IsSuperUser]
GO
ALTER TABLE [dbo].[MstUser]
	ADD
	CONSTRAINT [DF_MstUser_IsActive]
	DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MstUser]
	ADD
	CONSTRAINT [DF_MstUser_IsAllowRemote]
	DEFAULT ((1)) FOR [IsAllowRemote]
GO
ALTER TABLE [dbo].[MstUser]
	ADD
	CONSTRAINT [DF_MstUser_IsNOCUser]
	DEFAULT ((0)) FOR [IsNOCUser]
GO
CREATE NONCLUSTERED INDEX [IX_MstUser]
	ON [dbo].[MstUser] ([MemberId])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstUser] SET (LOCK_ESCALATION = TABLE)
GO
