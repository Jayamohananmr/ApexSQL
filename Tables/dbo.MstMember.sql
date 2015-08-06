SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MstMember] (
		[MemberId]                 [bigint] NOT NULL,
		[MemberCode]               [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MemberName]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DtRegistr]                [datetime] NULL,
		[Designation]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Logo]                     [image] NULL,
		[Address]                  [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[City]                     [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[State]                    [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Country]                  [bigint] NULL,
		[ZipCode]                  [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TelNo]                    [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MobileNo]                 [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FName]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EmailId]                  [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SMSAlert]                 [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsActive]                 [bit] NULL,
		[ActivedOn]                [datetime] NULL,
		[MgMtUser]                 [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IslLiteOption]            [tinyint] NULL,
		[IslLiteStartOn]           [datetime] NULL,
		[IslLiteEndOn]             [datetime] NULL,
		[CWSync]                   [tinyint] NULL,
		[CWPassword]               [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CWStartON]                [datetime] NULL,
		[CWEndON]                  [datetime] NULL,
		[DisabledOn]               [datetime] NULL,
		[AllowCWTicket]            [bit] NULL,
		[FreezeEffectedOn]         [datetime] NULL,
		[UnFreezeEffectedOn]       [datetime] NULL,
		[AllowCWTicketStart]       [datetime] NULL,
		[AllowCWTicketEnd]         [datetime] NULL,
		[IsBoxOfficeEnabled]       [bit] NULL,
		[ISBoxOfficeEnabledOn]     [datetime] NULL,
		[Referral]                 [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SalesEmailId]             [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ISFreezed]                [bit] NULL,
		[IsAutoTask]               [bit] NULL,
		[AutoTaskStart]            [datetime] NULL,
		[AutoTaskEnd]              [datetime] NULL,
		[AutoTaskGuid]             [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SalesForceRefAccID]       [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MemberTier]               [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TopCategory]              [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IncludeNOCSign]           [int] NULL,
		[IsPartnerGroup]           [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [PK_MstMember]
	PRIMARY KEY
	CLUSTERED
	([MemberId])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF__MstMember__Allow__5441852A]
	DEFAULT ((0)) FOR [AllowCWTicket]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF__MstMember__CWSyn__4CA06362]
	DEFAULT ((0)) FOR [CWSync]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF__mstmember__IsAut__2180FB33]
	DEFAULT ((0)) FOR [IsAutoTask]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF__mstmember__ISFre__1EA48E88]
	DEFAULT ((0)) FOR [ISFreezed]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF__MstMember__IslLi__4BAC3F29]
	DEFAULT ((0)) FOR [IslLiteOption]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF_MstMember_DtRegistr]
	DEFAULT (getdate()) FOR [DtRegistr]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF_MstMember_IsActive]
	DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MstMember]
	ADD
	CONSTRAINT [DF_MstMember_IsBoxOfficeEnabled]
	DEFAULT ((0)) FOR [IsBoxOfficeEnabled]
GO
CREATE NONCLUSTERED INDEX [IX_MstMember]
	ON [dbo].[MstMember] ([MemberName])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstMember] SET (LOCK_ESCALATION = TABLE)
GO
