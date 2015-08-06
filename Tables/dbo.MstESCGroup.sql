SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MstESCGroup] (
		[AccGroupId]                  [bigint] NOT NULL,
		[MemberId]                    [bigint] NULL,
		[GroupName]                   [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pk_AC_Holder_UID]            [bigint] NULL,
		[ESC1_UIDS]                   [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC2_UIDS]                   [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC3_UIDS]                   [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC4_UIDS]                   [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC5_UIDS]                   [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AutoMated_UID]               [bigint] NULL,
		[AutoMated_GRP]               [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Auto_Rpt_UID]                [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Notes]                       [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC1_UIDS_ABH]               [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC2_UIDS_ABH]               [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC3_UIDS_ABH]               [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC4_UIDS_ABH]               [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ESC5_UIDS_ABH]               [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Aft_bus_hr]                  [bit] NULL,
		[BusinessHR_Fromtime]         [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BusinessHR_ToTime]           [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[After_Business_Fromtime]     [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[After_Business_Totime]       [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[After_Business_Wkdys]        [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BusinessHR_Wkdys]            [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DcDtime]                     [datetime] NULL,
		[CALLNONB]                    [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstESCGroup]
	ADD
	CONSTRAINT [PK_MstESCGroup]
	PRIMARY KEY
	NONCLUSTERED
	([AccGroupId])
	WITH FILLFACTOR=80
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstESCGroup]
	ADD
	CONSTRAINT [DF__MstEscGro__CALLN__74AE54BC]
	DEFAULT ((0)) FOR [CALLNONB]
GO
ALTER TABLE [dbo].[MstESCGroup]
	ADD
	CONSTRAINT [DF__MSTESCGRO__DcDti__6A30C649]
	DEFAULT (getdate()) FOR [DcDtime]
GO
ALTER TABLE [dbo].[MstESCGroup]
	ADD
	CONSTRAINT [DF_MstESCGroup_Aft_bus_hr]
	DEFAULT ((0)) FOR [Aft_bus_hr]
GO
CREATE CLUSTERED INDEX [IX_MstESCGroup]
	ON [dbo].[MstESCGroup] ([MemberId])
	WITH ( FILLFACTOR = 90)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MstESCGroup] SET (LOCK_ESCALATION = TABLE)
GO
