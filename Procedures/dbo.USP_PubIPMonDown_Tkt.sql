SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_PubIPMonDown_Tkt]
@InMode INT,
@InMemberID BIGINT=NULL,
@InSiteID BIGINT=NULL 
AS
/*     
 
EXEC [USP_PubIPMonDown_Tkt] 1,NULL,NULL 
EXEC [USP_PubIPMonDown_Tkt] 2,NULL,NULL
EXEC [USP_PubIPMonDown_Tkt] 3,1,1 
EXEC [USP_PubIPMonDown_Tkt] 3,1,199
EXEC [USP_PubIPMonDown_Tkt] 3,142,125245 
====================PURPOSE=========================
To generate Public IP Down tickets if Status received as 'Down'.        
=====================OUTPUT==========================
INPUT PARAMETERS :
	@InMode INT,
	@InMemberID BIGINT,
	@InSiteID BIGINT 
OUTPUT PARAMETERS : 
	RECORD SET
=====================PAGE NAME(CALLING)==============  
Called by EXE :  
=====================CREATED BY/DATE ================      
Anamika Pandey
10th July 2014
=====================CHANGED BY/DATE ================      
Anamika Pandey
12th Sep 2014
Handled ISNULL condition where we are getting NULL values.
=====================CHANGED BY/DATE ================      
Anamika Pandey
17th Sep 2014
Removed Hard coded member and siteid.
*/       
--------------------------------------------------------------------  
SET NOCOUNT ON

	IF @InMode=1
		BEGIN
			SELECT DISTINCT RM.MemberID,MM.MemberName,MM.MemberCode,MS.SiteId,MS.SiteName,MS.Sitecode,
				   CASE WHEN Cons.SiteID IS NULL THEN 'NEW' ELSE 'UPDATE' END AS [TktStatus],11498 AS ConditionID,
				   Cons.TaskRawID,MS.ServiceId_Server    
			FROM RegMain RM WITH(NOLOCK)
			INNER JOIN MstMember MM WITH(NOLOCK) ON MM.MemberId=RM.MemberID 
			INNER JOIN RegRSMAliveStatus RS WITH(NOLOCK) ON RS.RegID=RM.RegId AND RS.RegStatus='ENABLED'
			INNER JOIN MstSite MS WITH(NOLOCK) ON MS.MemberId=RM.MemberID AND MS.SiteId=RM.SiteId 
			INNER JOIN PubIPMon_Config P WITH(NOLOCK) ON P.PubIPRegID=RM.RegId 
			INNER JOIN PubIPMon_ConfigStatus PC WITH(NOLOCK) ON PC.PubIPRegID=RM.RegId 
			LEFT JOIN (
						SELECT DISTINCT AC.MemberID,AC.SiteID,AC.TaskRawID 
						FROM PubIPMon_ConfigSts_Cons AC WITH(NOLOCK) 
					   ) AS Cons ON Cons.MemberID=RM.MemberID AND Cons.SiteID=RM.SiteId 
			LEFT JOIN PubIPMon_ConfigSts_Cons AC WITH(NOLOCK) ON AC.PubIPRegID=RM.RegId 
			WHERE MM.IsActive=1 AND MS.IsEnabled=1 AND PC.IPStatus <>'UP' AND RM.ResMonEnabled=1 
				AND AC.PubIPRegID IS NULL AND MS.ServiceId_Server IN (5,6) AND ISNULL(PC.TracertDesc,'')<>'' 
	END
	---------------------------------------------------------------------------
	IF @InMode=2
		BEGIN
			SELECT RM.MemberID,MM.MemberName,MM.MemberCode,MS.SiteId,MS.SiteName,MS.Sitecode,
				   C.PubIPRegID,C.PubIPAddrss,RM.ResourceName,ISNULL(RM.ResFriendlyName,'') AS ResFriendlyName,11498 AS ConditionID, 
				   C.TaskRawID,'CLOSE' AS [TktStatus],MS.ServiceId_Server   
			FROM PubIPMon_ConfigSts_Cons C WITH(NOLOCK)
			INNER JOIN RegMain RM WITH(NOLOCK) ON C.MemberID=RM.MemberID AND C.SiteID=RM.SiteId AND C.PubIPRegID=RM.RegId 
			INNER JOIN MstMember MM WITH(NOLOCK) ON MM.MemberId=RM.MemberID 
			INNER JOIN RegRSMAliveStatus RS WITH(NOLOCK) ON RS.RegID=RM.RegId  AND RS.RegStatus='ENABLED'
			INNER JOIN MstSite MS WITH(NOLOCK) ON MS.MemberId=RM.MemberID AND MS.SiteId=RM.SiteId 
			INNER JOIN PubIPMon_Config P WITH(NOLOCK) ON P.PubIPRegID=RM.RegId 			
			INNER JOIN PubIPMon_ConfigStatus PC WITH(NOLOCK) ON PC.PubIPRegID=RM.RegId 
			WHERE  MM.IsActive=1 AND MS.IsEnabled=1 AND PC.IPStatus='UP' AND RM.ResMonEnabled=1 
				AND MS.ServiceId_Server IN (5,6) AND ISNULL(PC.TracertDesc,'')=''
			ORDER BY MS.SiteId  
		END
		---------------------------------------------------------------------------
	IF @InMode=3
		BEGIN
			SELECT  RM.MemberID,MM.MemberName,MM.MemberCode,MS.SiteId,MS.SiteName,MS.Sitecode,
					RM.RegID,RM.ResourceName,ISNULL(RM.ResFriendlyName,'') AS ResFriendlyName,PC.PubIPAddrs,
					ISNULL(PC.ErrDesc,'') AS ErrDesc,ISNULL(PC.TracertDesc,'') AS TracertDesc, 
					11498 AS ConditionID,Cons.TaskRawID,MS.ServiceId_Server   
			FROM RegMain RM WITH(NOLOCK)
			INNER JOIN MstMember MM WITH(NOLOCK) ON MM.MemberId=RM.MemberID 
			INNER JOIN RegRSMAliveStatus RS WITH(NOLOCK) ON RS.RegID=RM.RegId  AND RS.RegStatus='ENABLED'
			INNER JOIN MstSite MS WITH(NOLOCK) ON MS.MemberId=RM.MemberID AND MS.SiteId=RM.SiteId 
			INNER JOIN PubIPMon_Config P WITH(NOLOCK) ON P.PubIPRegID=RM.RegId 			
			INNER JOIN PubIPMon_ConfigStatus PC WITH(NOLOCK) ON PC.PubIPRegID=RM.RegId 
			LEFT JOIN (
						SELECT DISTINCT AC.TaskRawID,AC.PubIPRegID 
						FROM PubIPMon_ConfigSts_Cons AC WITH(NOLOCK) 
					   ) AS Cons ON Cons.PubIPRegID=RM.RegId 
			WHERE MS.IsEnabled=1 AND RM.MemberID=@InMemberID AND RM.SiteId=@InSiteID AND PC.IPStatus <>'UP'
				AND RM.ResMonEnabled=1 AND MS.ServiceId_Server IN (5,6) AND ISNULL(PC.TracertDesc,'')<>'' 
			ORDER BY RM.RegId 
		END
SET NOCOUNT OFF
GO
