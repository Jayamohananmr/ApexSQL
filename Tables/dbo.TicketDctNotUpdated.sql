SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TicketDctNotUpdated] (
		[RegID]             [bigint] NOT NULL,
		[TktID]             [bigint] NOT NULL,
		[ExecutionDate]     [datetime] NOT NULL,
		[CreatedDate]       [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TicketDctNotUpdated]
	ADD
	CONSTRAINT [DF_TicketDctNotUpdated_createdt]
	DEFAULT (getdate()) FOR [CreatedDate]
GO
CREATE CLUSTERED INDEX [IX_TicketDctNotUpdated_1]
	ON [dbo].[TicketDctNotUpdated] ([RegID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TicketDctNotUpdated_2]
	ON [dbo].[TicketDctNotUpdated] ([TktID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[TicketDctNotUpdated] SET (LOCK_ESCALATION = TABLE)
GO
