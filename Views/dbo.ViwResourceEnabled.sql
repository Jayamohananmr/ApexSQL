SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViwResourceEnabled]
  
AS
SELECT     dbo.RegDPMAliveStatus.RegId, dbo.RegDPMAliveStatus.RegStatus, dbo.RegMain.RegType, dbo.RegMain.ExcludePatch, 
                      dbo.RegMain.ResMonEnabled, dbo.RegMain.ResMonStatus, dbo.RegMain.MemberCode, dbo.RegMain.SiteCode, dbo.RegMain.SiteSubCode, 
                      dbo.RegMain.MemberID, dbo.RegMain.SiteId, dbo.RegMain.ResourceName, dbo.RegMain.IPAddresses, 
                      CASE RegType WHEN 'DPMA' THEN 'WorkStation' ELSE 'Server' END AS DomainRole, dbo.RegMain.OS, dbo.RegMain.OSVersion, 
                      dbo.RegMain.ResFriendlyName, dbo.RegMain.GUID, dbo.RegMain.ResType, dbo.MstSite.SiteName AS Site_Name, dbo.RegDPMAliveStatus.DCTime, 
                      dbo.RegMain.Createdon, dbo.RegMain.ParentID
FROM         dbo.RegDPMAliveStatus INNER JOIN
                      dbo.RegMain ON dbo.RegDPMAliveStatus.RegId = dbo.RegMain.RegId INNER JOIN
                      dbo.MstSite ON dbo.MstSite.SiteId = dbo.RegMain.SiteId
WHERE     (dbo.RegDPMAliveStatus.RegStatus NOT IN ('UNINSTALL', 'UNINSTALL DOWNLOAD', 'EXCLUDE')) AND (dbo.RegMain.RegType IN ('DPMA'))
UNION ALL
SELECT     dbo.RegRSMAliveStatus.RegId, dbo.RegRSMAliveStatus.RegStatus, RegMain_1.RegType, RegMain_1.ExcludePatch, RegMain_1.ResMonEnabled, 
                      RegMain_1.ResMonStatus, RegMain_1.MemberCode, RegMain_1.SiteCode, RegMain_1.SiteSubCode, RegMain_1.MemberID, RegMain_1.SiteId, 
                      RegMain_1.ResourceName, RegMain_1.IPAddresses, CASE RegType WHEN 'DPMA' THEN 'WorkStation' ELSE 'Server' END AS DomainRole, 
                      RegMain_1.OS, RegMain_1.OSVersion, RegMain_1.ResFriendlyName, RegMain_1.GUID, RegMain_1.ResType, MstSite_1.SiteName AS Site_Name, 
                      dbo.RegRSMAliveStatus.DCTime, RegMain_1.Createdon, RegMain_1.ParentID
FROM         dbo.RegRSMAliveStatus INNER JOIN
                      dbo.RegMain AS RegMain_1 ON dbo.RegRSMAliveStatus.RegId = RegMain_1.RegId INNER JOIN
                      dbo.MstSite AS MstSite_1 ON MstSite_1.SiteId = RegMain_1.SiteId
WHERE     (dbo.RegRSMAliveStatus.RegStatus NOT IN ('UNINSTALL', 'UNINSTALL DOWNLOAD', 'EXCLUDE')) AND (RegMain_1.RegType IN ('MSMA', 'RSMA'))

 

GO
