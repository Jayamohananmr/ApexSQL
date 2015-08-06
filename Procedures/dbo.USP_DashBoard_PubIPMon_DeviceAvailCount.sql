SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_DashBoard_PubIPMon_DeviceAvailCount]
@InMemberID BIGINT,
@InUserType BIT, 
@InUserID BIGINT

AS
/*  
==============================================================
 
EXEC [USP_DashBoard_PubIPMon_DeviceAvailCount] 1,1,NULL 
 
EXEC [USP_DashBoard_PubIPMon_DeviceAvailCount] 1,0,26547
 
==================PURPOSE=====================================
To show the count of Servers and Linux agents for which monitoring stoppet in Device Availability Summary in Dashboard.  
=====================INPUT PARAMS=============================
@InMode CHAR(4),
@InMemberID BIGINT,
@InUserID BIGINT,
@InUserType BIT
=====================OUTPUT PARAMS============================
@OUTServers INT	OUTPUT
=====================PAGE NAME(CALLING)=======================
dashb_DeviceAvail.asp
=====================CREATED BY/DATE =========================    
Anamika Pandey
14th Aug 2014
=====================CREATED BY/DATE =========================    
Anamika Pandey
4th Aug 2015
Added case to exclude resources that are reporting in last 10 mins and also added Tracert should not be blank.
i.e. DATEDIFF(MI,C.DCTime,GETDATE())> = 10	AND ISNULL(T.TracertDesc,'')<>''
--------------------------------------------------------------
*/

SET NOCOUNT ON

	DECLARE @TEMP TABLE
	(
		MemberID BIGINT,
		SiteId  BIGINT,
		SupRegID BIGINT,
		GrpID BIGINT,
		PubIPRegID BIGINT,
		IPStatus VARCHAR(50),
		DownTime DATETIME ,
		TracertDesc VARCHAR(1000)  
	)

	INSERT INTO @TEMP 
	SELECT R.MemberID,R.SiteId,R.RegID SupRegID,PS.GrpID,PC.PubIPRegID,CS.IPStatus,ISNULL(CS.UpDcdTime,CS.DcdTime) AS DownTime ,CS.TracertDesc 
	FROM RegMain R WITH (NOLOCK)
	INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=R.REgID AND C.RegStatus='ENABLED'  
	INNER JOIN PubIPMon_SupRegIDMapping PS WITH(NOLOCK) ON PS.SupRegID=R.RegId  
	INNER JOIN MstPubIPMon_Group G WITH(NOLOCK) ON G.GrpID=PS.GrpID  
	INNER JOIN PubIPMon_Config PC WITH(NOLOCK) ON PC.GrpID =G.GrpID  
	INNER JOIN PubIPMon_ConfigStatus CS WITH(NOLOCK) ON CS.PubIPRegID=PC.PubIPRegID 
	WHERE R.MemberID =@InMemberID AND R.RegType='MSMA' AND G.IsEnabled=1 AND R.ResMonEnabled=1 AND R.ResType IN (1,7)
	ORDER BY R.RegId 

	IF @InUserType =1
		BEGIN
			SELECT RM.ResType,COUNT(DISTINCT ISNULL(T.SupRegID,0)) RegIDCnt  
			FROM @TEMP T 
			INNER JOIN RegMain RM WITH(NOLOCK) ON RM.RegId=T.SupRegID 
			INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=RM.REgID AND C.RegStatus='ENABLED'  
			INNER JOIN MstSite S WITH(NOLOCK) ON S.SITEID=RM.SiteId AND S.IsBDROnly=0  
			LEFT JOIN @TEMP T1 ON T1.SupRegID=T.SupRegID AND T1.IPStatus='UP'
			WHERE RM.MemberID=@InMemberID AND T1.SupRegID IS NULL AND DATEDIFF(MI,C.DCTime,GETDATE())> = 10 AND ISNULL(T.TracertDesc,'')<>''
			GROUP BY ResType
		END
	ELSE
		BEGIN
			SELECT RM.ResType,COUNT(DISTINCT ISNULL(T.SupRegID,0)) RegIDCnt    
			FROM @TEMP T
			INNER JOIN RegMain RM WITH(NOLOCK) ON RM.RegId=T.SupRegID 
			INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=RM.REgID AND C.RegStatus='ENABLED'  
			INNER JOIN MstSite S WITH(NOLOCK) ON S.SITEID=RM.SiteId AND S.IsBDROnly=0  
			INNER JOIN UserSiteAccess US WITH(NOLOCK) ON US.SiteID=S.SiteId 
			LEFT JOIN @TEMP T1 ON T1.SupRegID=T.SupRegID AND T1.IPStatus='UP'
			WHERE RM.MemberID=@InMemberID AND US.UserId=@InUserID AND T1.SupRegID IS NULL AND DATEDIFF(MI,C.DCTime,GETDATE())> = 10 AND ISNULL(T.TracertDesc,'')<>''
			GROUP BY ResType				
		END
SET NOCOUNT OFF
GO
