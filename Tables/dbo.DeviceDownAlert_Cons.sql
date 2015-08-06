SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DeviceDownAlert_Cons] (
		[RegId]           [bigint] NULL,
		[AlertId]         [bigint] NULL,
		[ConditionId]     [bigint] NULL,
		[CloseStatus]     [int] NULL,
		[DcDtime]         [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[DeviceDownAlert_Cons]
	ADD
	CONSTRAINT [DF__DeviceDow__Close__02C769E9]
	DEFAULT ((0)) FOR [CloseStatus]
GO
ALTER TABLE [dbo].[DeviceDownAlert_Cons]
	ADD
	CONSTRAINT [DF__DeviceDow__DcDti__03BB8E22]
	DEFAULT (getdate()) FOR [DcDtime]
GO
CREATE CLUSTERED INDEX [IX_Regid]
	ON [dbo].[DeviceDownAlert_Cons] ([RegId])
	ON [Second]
GO
ALTER TABLE [dbo].[DeviceDownAlert_Cons] SET (LOCK_ESCALATION = TABLE)
GO
