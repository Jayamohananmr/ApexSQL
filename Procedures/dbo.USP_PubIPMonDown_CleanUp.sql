SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_PubIPMonDown_CleanUp]
AS
--------------------------------------------------------------------  
/*     
 
EXEC [USP_PubIPMonDown_CleanUp] 
====================PURPOSE=========================
To perform cleanup process if IP gets removed from Portal and tickets already exists.     
=====================OUTPUT==========================
INPUT PARAMETERS :
	NONE
OUTPUT PARAMETERS : 
	RECORD SET
=====================PAGE NAME(CALLING)==============  
Called by EXE : 
=====================CREATED BY/DATE ================      
Anamika Pandey
10th July 2014
=====================CHANGED BY/DATE ================      
Anamika Pandey
8th August 2014
Changed Condition ID.
*/       
--------------------------------------------------------------------  
SET NOCOUNT ON

	DECLARE @CleanUpTask TABLE 
	(
		MemberID BIGINT, 
		SiteID BIGINT, 
		TaskRawId VARCHAR(100), 
		PubIPRegId BIGINT, 
		PubIPAddrs VARCHAR(100), 
		ResType VARCHAR(10), 
		Reason VARCHAR(100),
		ServiceId_Server INT
	)

	INSERT INTO @CleanUpTask(MemberID,SiteID,TaskRawId,PubIPRegId,PubIPAddrs,ResType,Reason,ServiceId_Server)	 
	
	SELECT R.MemberID,R.SiteId,C.TaskRawID,C.PubIPRegID,C.PubIPAddrss,R.ResType,
		   CASE WHEN RS.REGID IS NULL THEN 'IP Removed' END AS Reason,ST.ServiceId_Server   
	FROM PubIPMon_ConfigSts_Cons  C WITH (NOLOCK)
	INNER JOIN RegMain R WITH (NOLOCK) ON R.RegId=C.PubIPRegID 
	INNER JOIN MstSite ST WITH(NOLOCK) ON ST.MemberID =C.MemberId AND ST.SiteId =C.SiteId
	LEFT JOIN RegRSMAliveStatus RS WITH (NOLOCK) ON RS.RegId=R.RegID AND RS.RegStatus='ENABLED'
	WHERE  ST.IsEnabled=1 AND R.ResMonEnabled=1 AND ST.ServiceId_Server IN (5,6) AND RS.REGID IS NULL  

	SELECT C.MemberID,C.SiteID,C.TaskRawId,C.PubIPRegId,C.ResType,C.Reason,
		   CASE WHEN SC.TCount=TC.TCount THEN 'FULL' ELSE 'PARTIAL' END [CLOSE],11498 AS ConditionID,C.ServiceId_Server   
	FROM @CleanUpTask C
	INNER JOIN (
					SELECT MemberId,SiteId,TaskRawID,COUNT(1) TCount 
					FROM PubIPMon_ConfigSts_Cons SC WITH (NOLOCK)
					GROUP BY MemberID, SiteID, TaskRawID
				)SC ON SC.MemberID=C.MemberID AND SC.SiteID=C.SiteID AND SC.TaskRawID=C.TaskRawID
	INNER JOIN (
					SELECT MemberId, SiteId, TaskRawID, COUNT(1) TCount 
					FROM @CleanUpTask 
					GROUP BY MemberID, SiteID, TaskRawID
				)TC ON TC.MemberID=C.MemberID AND TC.SiteID=C.SiteID AND TC.TaskRawID=C.TaskRawID
	ORDER BY C.SiteID,C.TaskRawId 
	
SET NOCOUNT OFF
GO
