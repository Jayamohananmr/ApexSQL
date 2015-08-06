SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimeZone] (
		[ZoneName]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS SPARSE NULL,
		[Timediff]               [numeric](10, 2) NULL,
		[ZoneSortOrder]          [int] NULL,
		[ZoneDisplayName]        [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UTCTimediff]            [numeric](10, 2) NULL,
		[UTCZoneSortOrder]       [int] NULL,
		[UTCZoneDisplayName]     [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Second]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Difference of time in minutes from pst.', 'SCHEMA', N'dbo', 'TABLE', N'TimeZone', 'COLUMN', N'Timediff'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Display name of the zone.', 'SCHEMA', N'dbo', 'TABLE', N'TimeZone', 'COLUMN', N'ZoneDisplayName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Zone name of various time zone Ex [PST]', 'SCHEMA', N'dbo', 'TABLE', N'TimeZone', 'COLUMN', N'ZoneName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Sort order of  the zone', 'SCHEMA', N'dbo', 'TABLE', N'TimeZone', 'COLUMN', N'ZoneSortOrder'
GO
ALTER TABLE [dbo].[TimeZone] SET (LOCK_ESCALATION = TABLE)
GO
