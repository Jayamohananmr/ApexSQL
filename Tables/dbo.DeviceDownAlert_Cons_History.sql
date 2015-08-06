SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DeviceDownAlert_Cons_History] (
		[RegId]           [bigint] NULL,
		[AlertId]         [bigint] NULL,
		[ConditionId]     [bigint] NULL,
		[CloseStatus]     [int] NULL,
		[DcDtime]         [datetime] NULL,
		[InsertedOn]      [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[DeviceDownAlert_Cons_History]
	ADD
	CONSTRAINT [DF__DeviceDow__Inser__05A3D694]
	DEFAULT (getdate()) FOR [InsertedOn]
GO
CREATE CLUSTERED INDEX [IX_Regid]
	ON [dbo].[DeviceDownAlert_Cons_History] ([RegId])
	ON [Second]
GO
ALTER TABLE [dbo].[DeviceDownAlert_Cons_History] SET (LOCK_ESCALATION = TABLE)
GO
