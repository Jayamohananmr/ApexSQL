SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_DashBoard_PubIPMon_Stopped_PR]
@InMode CHAR(4),
@InMemberID BIGINT,
@InUserID BIGINT,
@InUserType BIT,
@OUTServers INT	OUTPUT
AS
/*  
==============================================================
DECLARE @OUTServers INT	
EXEC [USP_DashBoard_PubIPMon_Stopped_PR] 'C',1,NULL,1, @OUTServers OUTPUT
SELECT  @OUTServers 
GO
DECLARE @OUTServers INT	
EXEC [USP_DashBoard_PubIPMon_Stopped_PR] 'D',1,NULL,1, @OUTServers OUTPUT
SELECT  @OUTServers 
GO
DECLARE @OUTServers INT	
EXEC [USP_DashBoard_PubIPMon_Stopped_PR] 'C',1,NULL,1, @OUTServers OUTPUT
SELECT  @OUTServers 
GO
DECLARE @OUTServers INT	
EXEC [USP_DashBoard_PubIPMon_Stopped_PR] 'D',1,NULL,0, @OUTServers OUTPUT
SELECT  @OUTServers
==================PURPOSE=====================================
To show the count and details of Monitoring Stopped Servers in Dashboard under Agent Status Section. 
=====================INPUT PARAMS=============================
@InMode CHAR(4),
@InMemberID BIGINT,
@InUserID BIGINT,
@InUserType BIT
=====================OUTPUT PARAMS============================
@OUTServers INT	OUTPUT
=====================PAGE NAME(CALLING)=======================
dashb_Status.ASP 
dashb_MonStop_DevServer_ui.asp 
dashb_MonStop_DevServer_Exp2Exl.asp
=====================CREATED BY/DATE =========================    
Anamika Pandey
1st July 2015
Created with _PR and handled case to exclude resources that are reporting in last 10 mins and also added Tracert should not be blank.
i.e. DATEDIFF(MI,C.DCTime,GETDATE())> = 10	AND ISNULL(T.TracertDesc,'')<>''
RMM-5139/RMM-5549
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
		DownTime DATETIME,
		TracertDesc VARCHAR(1000)  
	)

	INSERT INTO @TEMP 
	SELECT R.MemberID,R.SiteId,R.RegID SupRegID,PS.GrpID,PC.PubIPRegID,CS.IPStatus,ISNULL(CS.UpDcdTime,CS.DcdTime) AS DownTime,CS.TracertDesc  
	FROM RegMain R WITH (NOLOCK)
	INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=R.REgID AND C.RegStatus='ENABLED'  
	INNER JOIN PubIPMon_SupRegIDMapping PS WITH(NOLOCK) ON PS.SupRegID=R.RegId  
	INNER JOIN MstPubIPMon_Group G WITH(NOLOCK) ON G.GrpID=PS.GrpID  
	INNER JOIN PubIPMon_Config PC WITH(NOLOCK) ON PC.GrpID =G.GrpID  
	INNER JOIN PubIPMon_ConfigStatus CS WITH(NOLOCK) ON CS.PubIPRegID=PC.PubIPRegID 
	WHERE R.MemberID =@InMemberID AND R.RegType='MSMA' AND G.IsEnabled=1 AND R.ResMonEnabled=1
	ORDER BY R.RegId 

	IF @InUserType =1
		BEGIN
			IF @InMode='C'
				BEGIN
					SELECT @OUTServers=COUNT(1) 
					FROM
					(
						SELECT  COUNT(DISTINCT T.SupRegID) SupRegID 
						FROM @TEMP T 
						INNER JOIN RegMain RM WITH(NOLOCK) ON RM.RegId=T.SupRegID 
						INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=RM.REgID AND C.RegStatus='ENABLED'  
						INNER JOIN MstSite S WITH(NOLOCK) ON S.SITEID=RM.SiteId AND S.IsBDROnly=0  
						LEFT JOIN @TEMP T1 ON T1.SupRegID=T.SupRegID AND T1.IPStatus='UP'
						WHERE RM.MemberID=@InMemberID AND T1.SupRegID IS NULL AND DATEDIFF(MI,C.DCTime,GETDATE())> = 10 AND ISNULL(T.TracertDesc,'')<>''
						GROUP BY S.SiteName,RM.REGID,RM.ResourceName,RM.ResFriendlyName,RM.OS,RM.ResType
					) A
				END
			IF @InMode='D'
				BEGIN
					SELECT DISTINCT S.SiteName AS Site_name,RM.REGID,RM.ResourceName,RM.ResFriendlyName,RM.OS,MIN(T.DownTime) AS MonDt,
						  'All Associated set of Public IP''s are Down.' AS Reason,RM.ResType
					FROM @TEMP T 
					INNER JOIN RegMain RM WITH(NOLOCK) ON RM.RegId=T.SupRegID 
					INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=RM.REgID AND C.RegStatus='ENABLED'  
					INNER JOIN MstSite S WITH(NOLOCK) ON S.SITEID=RM.SiteId AND S.IsBDROnly=0  
					LEFT JOIN @TEMP T1 ON T1.SupRegID=T.SupRegID AND T1.IPStatus='UP'
					WHERE RM.MemberID=@InMemberID AND T1.SupRegID IS NULL AND DATEDIFF(MI,C.DCTime,GETDATE())> = 10	AND ISNULL(T.TracertDesc,'')<>''
					GROUP BY S.SiteName,RM.REGID,RM.ResourceName,RM.ResFriendlyName,RM.OS,RM.ResType
				END
		END
	ELSE
		BEGIN
			IF @InMode='C'
				BEGIN
					SELECT @OUTServers=COUNT(1) 
					FROM
					(
						SELECT  COUNT(DISTINCT T.SupRegID) SupRegID   
						FROM @TEMP T
						INNER JOIN RegMain RM WITH(NOLOCK) ON RM.RegId=T.SupRegID 
						INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=RM.REgID AND C.RegStatus='ENABLED'  
						INNER JOIN MstSite S WITH(NOLOCK) ON S.SITEID=RM.SiteId AND S.IsBDROnly=0  
						INNER JOIN UserSiteAccess US WITH(NOLOCK) ON US.SiteID=S.SiteId 
						LEFT JOIN @TEMP T1 ON T1.SupRegID=T.SupRegID AND T1.IPStatus='UP'
						WHERE RM.MemberID=@InMemberID AND US.UserId=@InUserID AND T1.SupRegID IS NULL AND DATEDIFF(MI,C.DCTime,GETDATE())> = 10	
						AND ISNULL(T.TracertDesc,'')<>''
						GROUP BY S.SiteName,RM.REGID,RM.ResourceName,RM.ResFriendlyName,RM.OS,RM.ResType
					) A	
				END
			IF @InMode='D'
				BEGIN		
					SELECT DISTINCT S.SiteName AS Site_name,RM.ResourceName,RM.ResFriendlyName,RM.OS,MIN(T.DownTime) AS MonDt,
						  'All Associated set of Public IP''s are Down.' AS Reason,RM.ResType
					FROM @TEMP T 
					INNER JOIN RegMain RM WITH(NOLOCK) ON RM.RegId=T.SupRegID 
					INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=RM.REgID AND C.RegStatus='ENABLED'  
					INNER JOIN MstSite S WITH(NOLOCK) ON S.SITEID=RM.SiteId AND S.IsBDROnly=0  
					INNER JOIN UserSiteAccess US WITH(NOLOCK) ON US.SiteID=S.SiteId 
					LEFT JOIN @TEMP T1 ON T1.SupRegID=T.SupRegID AND T1.IPStatus='UP'
					WHERE RM.MemberID=@InMemberID AND US.UserId=@InUserID AND T1.SupRegID IS NULL AND DATEDIFF(MI,C.DCTime,GETDATE())> = 10	
					AND ISNULL(T.TracertDesc,'')<>''
					GROUP BY S.SiteName,RM.REGID,RM.ResourceName,RM.ResFriendlyName,RM.OS,RM.ResType
				END	
		END
SET NOCOUNT OFF
GO
