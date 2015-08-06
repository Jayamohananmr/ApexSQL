SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[USP_DeviceDownTkt_wAM_PR]
	@InValue Bigint,
	@InStartSiteid Bigint,
	@InEndSiteId Bigint	 
AS

--------------------------------------------------------------------  
/*         
EXEC [USP_DeviceDownTkt_wAM_PR] 600,1,5000
====================PURPOSE=========================    
To get the DeviceDownTkt 
=====================INPUT/OUTPUT===================  
INPUT parameter  
	@InValue Bigint,
	@InStartSiteid Bigint,
	@InEndSiteId Bigint
=====================PAGE NAME(CALLING)==============
called by exe : DeviceDown 
==========================CHANGED BY/DATE =========================  
Vishal Bhor
07 Aug 2012
Added  ResFriendlyName in select claues. 
==========================CHANGED BY/DATE =========================  
Prakriti Singh
01/11/2012
Added IsHavingDevice device count in recordset
==========================CHANGED BY/DATE =========================  
Prakriti Singh
03/07/2013
Created with _PR
==========================CHANGED BY/DATE =========================  
Prakriti Singh
03/07/2013
Added isproactive column
==========================CHANGED BY/DATE =========================  
Prakriti Singh
24/07/2013
Removed memberid Check
==========================CHANGED BY/DATE =========================  
Prakriti Singh
28/08/2013
Added a check to excluded BROnly site and NAS
and l.regid is null
and s.isbdronly =0
==========================CHANGED BY/DATE ========================= 
Anamika Pandey
28th July 2014
Created SP with _PR and Added logic to exclude Servers(while listing) that are suppressed by Public IP and that all IP's are down.
==========================CHANGED BY/DATE =========================  
Anamika Pandey
18th Aug 2014
Included testing members (142,10751)
*/   
--------------------------------------------------------------------  

SET NOCOUNT ON

	DECLARE @REGSTATUS VARCHAR(20)  

	SET @REGSTATUS='ENABLED'
	
	DECLARE @DEVICE TABLE 
	(
		PARENTID BIGINT,
		CNT INT
	)
	
	INSERT INTO @DEVICE (PARENTID,CNT)
	
	SELECT ParentID, COUNT(1) DeviceCount 
	FROM RegMain RR WITH(NOLOCK) 
	INNER JOIN REGRSMALIVESTATUS A WITH(NOLOCK) ON A.RegId =RR.RegId
	WHERE RR.ResType IN (3,4,5) AND A.RegStatus =@REGSTATUS
	GROUP BY ParentID
	--------------------------------------------------------------------------
	DECLARE @TEMP TABLE
	(
		MemberID BIGINT,
		SiteId  BIGINT,
		SupRegID BIGINT,
		GrpID BIGINT,
		PubIPRegID BIGINT,
		IPStatus VARCHAR(50) 
	)

	INSERT INTO @TEMP(MemberID,SiteId,SupRegID,GrpID,PubIPRegID,IPStatus) 
	
	SELECT  R.MemberID,R.SiteId,R.RegID SupRegID,PS.GrpID ,PC.PubIPRegID,CS.IPStatus 
	FROM RegMain R WITH (NOLOCK)
	INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=R.REgID AND C.RegStatus=@REGSTATUS 
	INNER JOIN PubIPMon_SupRegIDMapping PS WITH(NOLOCK) ON PS.SupRegID=R.RegId  
	INNER JOIN MstPubIPMon_Group G WITH(NOLOCK) ON G.GrpID=PS.GrpID  
	INNER JOIN PubIPMon_Config PC WITH(NOLOCK) ON PC.GrpID =G.GrpID  
	INNER JOIN PubIPMon_ConfigStatus CS WITH(NOLOCK) ON CS.PubIPRegID=PC.PubIPRegID 
	WHERE R.MemberID IN (142,10751) AND R.SiteID BETWEEN @InStartSiteid AND @InEndSiteId  
		AND R.RegType='MSMA' AND G.IsEnabled=1 AND R.ResMonEnabled=1

	--------------------------------------------------------------------------
	SELECT  DISTINCT V.REGID,RESOURCENAME,V.ResFriendlyName,MEMBERCODE,v.SiteCode,v.SiteSubCode,DATEDIFF(SS,RC.Dctime,GETDATE()) as [30SecTime],
			CASE WHEN L.REGID IS NOT NULL THEN 1 ELSE 0 END AS ISNAS,
			CASE WHEN L.REGID IS NOT NULL AND IsBDROnly =1 AND ServiceId_Server=5 THEN 1 ELSE 0 END ISBDRONLYWithZenithMon,
			ServiceId_Server,IsBDROnly,C.ThresholdCounter,C.Status TktStatus,C.JobPostStatus,C.Tktid,ISNULL(LM.lmihostid,0) lmihostid,V.SITEID,
			CASE WHEN P.ParentID IS NULL THEN 0 ELSE 1 END AS IsHavingDevice,ISNULL(IsProActive,0) AS IsProcAtive
	FROM RegMain V WITH(NOLOCK)
	LEFT JOIN [30Sec_AlrtCons] C WITH (NOLOCK) ON C.Regid = V.Regid
	INNER JOIN RegRSMAliveStatus ST WITH(NOLOCK) ON ST.RegId=V.RegId AND ST.RegStatus= @REGSTATUS
	LEFT JOIN NASREGLINK L WITH(NOLOCK) ON L.RegId=V.RegId
	INNER JOIN MSTSITE S WITH(NOLOCK) ON S.SiteId =V.SiteId
	LEFT JOIN RcDTime RC WITH(NOLOCK) ON RC.RegID =V.RegID
	LEFT JOIN LMIHostVerifList LM WITH(NOLOCK) ON LM.Regid = V.RegID
	LEFT JOIN @DEVICE P on P.ParentID = V.RegId
	LEFT JOIN 
	(
		SELECT DISTINCT T.SupRegID  
		FROM @TEMP T
		LEFT JOIN @TEMP T1 ON T1.SUPREGID=T.SUPREGID AND T1.IPStatus='UP'
		WHERE T1.SUPREGID IS NULL
	) SR ON SR.SupRegID =V.RegId 
	WHERE V.MemberID IN (142,10751) AND RESTYPE=1 AND V.REGTYPE='MSMA' AND V.PARENTID IS NULL 
	AND (
			(DATEDIFF(SS, RC.Dctime, GETDATE())>= @InValue AND C.TktID IS NULL)
				OR 
			(DATEDIFF(ss, RC.Dctime, GETDATE())>= 120 AND C.TktID IS NOT NULL)
				OR 
			(C.TktID IS NOT NULL AND DATEDIFF(SS,RC.Dctime,GETDATE())<@InValue)
				OR 
			(IsBDROnly =1 AND ServiceId_Server IN(4,5))	
				OR 
			(DATEDIFF(SS,RC.Dctime,GETDATE()) IS NULL) 
		)
	AND V.SiteID BETWEEN @InStartSiteid AND @InEndSiteId
	AND L.REGID IS NULL AND S.IsBDROnly=0 AND SR.SupRegID IS NULL

	OPTION(OPTIMIZE FOR(@REGSTATUS='-1'))  
 
SET NOCOUNT OFF





GO
