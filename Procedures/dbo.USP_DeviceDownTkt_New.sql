SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[USP_DeviceDownTkt_New]
	@InValue Bigint,
	@InStartSiteid Bigint,
	@InEndSiteId Bigint
	 
AS

--------------------------------------------------------------------  
/*         
USP_DeviceDownTkt_New 600,1,5000
 
==============================PURPOSE==============================   
 ===============================OUTPUT==============================   
  

==========================PAGE NAME(CALLING)=======================   
==========================CREATED BY/DATE =========================  
 
==========================CHANGED BY/DATE =========================  
*/   
--------------------------------------------------------------------  

SET NOCOUNT ON
	SELECT distinct V.REGID,RESOURCENAME,MEMBERCODE,v.SiteCode,v.SiteSubCode ,
		Datediff(ss, RC.Dctime, getdate()) as [30SecTime],
		CASE WHEN L.REGID IS NOT NULL THEN 1 ELSE 0 end AS ISNAS,
		CASE WHEN L.REGID is not null and IsBDROnly =1 AND ServiceId_Server=5 THEN 1 ELSE 0 END ISBDRONLYWithZenithMon,
		ServiceId_Server,IsBDROnly,C.ThresholdCounter,C.Status TktStatus,C.JobPostStatus,C.Tktid
		,isnull(LM.lmihostid,0) lmihostid,V.SITEID

	FROM REGMAIN V WITH(NOLOCK)
		Left Join [30Sec_AlrtCons] C with (nolock) on C.Regid = V.Regid
		INNER JOIN REGRSMALIVESTATUS ST WITH(NOLOCK)
		ON ST.REGID=V.REGID AND ST.REGSTATUS='ENABLED'
	LEFT JOIN NASREGLINK L WITH(NOLOCK) ON L.REGID=V.REGID
	INNER JOIN MSTSITE S WITH(NOLOCK) ON S.SITEID=V.SITEID
	LEFT JOIN RcDTime RC WITH(NOLOCK) ON RC.REGID=V.REGID
	LEFT JOIN LMIHostVerifList LM WITH(NOLOCK) ON LM.REGID = V.REGID
	WHERE V.PARENTID IS NULL and (
			(Datediff(ss, RC.Dctime, getdate())>= @InValue and c.tktid is null)
			or (c.tktid is not null and Datediff(ss, RC.Dctime, getdate())<@InValue)
			or (IsBDROnly =1 and ServiceId_Server in(4,5) )	
			or (Datediff(ss, RC.Dctime, getdate()) is null) )
		and V.SiteID between @InStartSiteid and @InEndSiteId 

 
SET NOCOUNT OFF



GO
