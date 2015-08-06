SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[USP_DeviceDownTkt_wAM]
	@InValue Bigint,
	@InStartSiteid Bigint,
	@InEndSiteId Bigint
	 
AS

--------------------------------------------------------------------  
/*         
 
EXEC [USP_DeviceDownTkt_wAM] 600,1,5000
====================PURPOSE=========================    
To get the DeviceDownTkt 
=====================INPUT/OUTPUT===================  
INPUT parameter  
	@InValue Bigint,
	@InStartSiteid Bigint,
	@InEndSiteId Bigint
=====================PAGE NAME(CALLING)==============
called by exe  
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
*/   
--------------------------------------------------------------------  

SET NOCOUNT ON

	DECLARE @REGSTATUS VARCHAR(20)  

	SET @REGSTATUS='ENABLED'
	
	DECLARE @DEVICE TABLE (PARENTID BIGINT,CNT INT)
	INSERT INTO @DEVICE (PARENTID,CNT)
	SELECT ParentID, COUNT(1) DeviceCount 
	FROM RegMain RR WITH(NOLOCK) 
	INNER JOIN REGRSMALIVESTATUS A WITH(NOLOCK) ON A.RegId =RR.RegId
	WHERE RR.ResType IN (3,4,5) and A.RegStatus =@REGSTATUS
	Group by ParentID
	
	
	SELECT distinct V.REGID,RESOURCENAME,V.ResFriendlyName ,MEMBERCODE,v.SiteCode,v.SiteSubCode ,
		Datediff(ss, RC.Dctime, getdate()) as [30SecTime],
		CASE WHEN L.REGID IS NOT NULL THEN 1 ELSE 0 end AS ISNAS,
		CASE WHEN L.REGID is not null and IsBDROnly =1 AND ServiceId_Server=5 THEN 1 ELSE 0 END ISBDRONLYWithZenithMon,
		ServiceId_Server,IsBDROnly,C.ThresholdCounter,C.Status TktStatus,C.JobPostStatus,C.Tktid
		,isnull(LM.lmihostid,0) lmihostid,V.SITEID,
		CASE WHEN P.ParentID IS NULL THEN 0 ELSE 1 END AS IsHavingDevice, Isnull(IsProActive,0) as IsProcAtive

	FROM REGMAIN V WITH(NOLOCK)
	LEFT JOIN [30Sec_AlrtCons] C with (nolock) on C.Regid = V.Regid
	INNER JOIN REGRSMALIVESTATUS ST WITH(NOLOCK) ON ST.REGID=V.REGID AND ST.REGSTATUS= @REGSTATUS
	LEFT JOIN NASREGLINK L WITH(NOLOCK) ON L.REGID=V.REGID
	INNER JOIN MSTSITE S WITH(NOLOCK) ON S.SITEID=V.SITEID
	LEFT JOIN RcDTime RC WITH(NOLOCK) ON RC.REGID=V.REGID
	LEFT JOIN LMIHostVerifList LM WITH(NOLOCK) ON LM.REGID = V.REGID
	LEFT JOIN @DEVICE P on P.ParentID = V.RegId
	WHERE RESTYPE=1 AND V.REGTYPE='MSMA' 
			AND V.PARENTID IS NULL and (
			(Datediff(ss, RC.Dctime, getdate())>= @InValue and c.tktid is null)
			or (Datediff(ss, RC.Dctime, getdate())>= 120 and c.tktid is not null)
			or (c.tktid is not null and Datediff(ss, RC.Dctime, getdate())<@InValue)
			or (IsBDROnly =1 and ServiceId_Server in(4,5) )	
			or (Datediff(ss, RC.Dctime, getdate()) is null) )
		and V.SiteID between @InStartSiteid and @InEndSiteId
		and l.regid is null
		and s.isbdronly =0

	OPTION(OPTIMIZE FOR(@REGSTATUS='-1'))  

 
SET NOCOUNT OFF





GO
