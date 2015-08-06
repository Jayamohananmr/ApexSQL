SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TicketDctNotUpdated_History] (
		[RegID]             [bigint] NOT NULL,
		[TktID]             [bigint] NOT NULL,
		[ExecutionDate]     [datetime] NOT NULL,
		[CreatedDate]       [datetime] NOT NULL,
		[InsertedOn]        [datetime] NULL
) ON [Second]
GO
ALTER TABLE [dbo].[TicketDctNotUpdated_History]
	ADD
	CONSTRAINT [DF__TicketDct__Inser__41B8C09B]
	DEFAULT (getdate()) FOR [InsertedOn]
GO
ALTER TABLE [dbo].[TicketDctNotUpdated_History]
	ADD
	CONSTRAINT [DF_TicketDctNotUpdated_createdt1]
	DEFAULT (getdate()) FOR [CreatedDate]
GO
CREATE CLUSTERED INDEX [Ix_Tkt]
	ON [dbo].[TicketDctNotUpdated_History] ([TktID])
	ON [Second]
GO
ALTER TABLE [dbo].[TicketDctNotUpdated_History] SET (LOCK_ESCALATION = TABLE)
GO
