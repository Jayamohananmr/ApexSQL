SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
GO



CREATE   PROCEDURE [dbo].[USP_DeviceDownTkt1]
	@InValue Bigint
	 
AS

--------------------------------------------------------------------  
/*         
USP_DeviceDownTkt 600
 
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

	FROM REGMAIN V WITH(NOLOCK)
		Left Join [30Sec_AlrtCons] C with (nolock) on C.Regid = V.Regid
		INNER JOIN REGRSMALIVESTATUS ST WITH(NOLOCK)
		ON ST.REGID=V.REGID AND ST.REGSTATUS='ENABLED'
	LEFT JOIN NASREGLINK L WITH(NOLOCK) ON L.REGID=V.REGID
	INNER JOIN MSTSITE S WITH(NOLOCK) ON S.SITEID=V.SITEID
	LEFT JOIN RcDTime RC WITH(NOLOCK) ON RC.REGID=V.REGID
	WHERE v.regid = 82511 and V.PARENTID IS NULL and (
			(Datediff(ss, RC.Dctime, getdate())>= @InValue and c.tktid is null)
			or (c.tktid is not null and Datediff(ss, RC.Dctime, getdate())<@InValue)
			or (IsBDROnly =1 and ServiceId_Server in(4,5) )	
			or (Datediff(ss, RC.Dctime, getdate()) is null) )

 
		 
SET NOCOUNT OFF
GO
