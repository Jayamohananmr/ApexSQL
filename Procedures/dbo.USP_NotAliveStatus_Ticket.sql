SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[USP_NotAliveStatus_Ticket]
AS
--------------------------------------------------------------------  
/*         

EXEC USP_NotAliveStatus_Ticket 

==============================PURPOSE==============================   
To generate tickets of those servers whose 30seconds data coming 
but alive status not coming.
===============================OUTPUT==============================   
Input Para
	None
Ouput Para
	None

==========================PAGE NAME(CALLING)======================= 
called by exe DCTimeNotRecd  
==========================CREATED BY/DATE =========================  
Deepesh Joshi
3/5/2008
==========================CHANGED BY/DATE =========================  
Roopali P
11 jan 2013
Added column ResFriendlyName in select list
*/   
--------------------------------------------------------------------  

SET NOCOUNT ON

BEGIN
--	SELECT v.regid ,V.MemberCode,V.SiteCode,v.SiteSubCode,V.ResourceName,datediff(hh,rs.DCTime,getdate()) [LastAliveStatusbefore],r.Dctime [30second], ServiceId_Server,
--			CASE WHEN r.regid is not null THEN 1 ELSE 0 END regidcount, tt.TktID  TktID 
--	FROM regmain v WITH(NOLOCK) 
--		INNER JOIN mstsite m WITH(NOLOCK) ON m.siteid=v.siteid
--		INNER JOIN regRSMALiveStatus rs WITH(NOLOCK) ON v.regid=rs.regid
--		LEFT JOIN RcDTime r  WITH(NOLOCK) ON v.regid=r.regid 
--		LEFT JOIN TicketDctNotUpdated tt WITH(NOLOCK) ON v.regid=tt.regid
--	WHERE   v.restype='1' AND v.MemberId<>142 AND ResMonEnabled=1 AND RegStatus='ENABLED'
--			AND datediff(hh,rs.DCTime,getdate()) >24 AND datediff(hh,r.dctime,getdate()) <24

		SELECT v.regid ,V.MemberCode,V.SiteCode,v.SiteSubCode,V.ResourceName,V.ResFriendlyName, ServiceId_Server,
		case when Q1.regid is not null then 1 else 0 end [RegIdCount], Q1.[LastAliveStatusbefore] , Q1.[30second], t.TktID 
		FROM regmain v WITH(NOLOCK)   
		INNER JOIN mstsite m WITH(NOLOCK) 
		On m.siteid=v.siteid 
		LEFT JOIN 
		(
			Select rs.RegId, datediff(hh,rs.DCTime,getdate()) [LastAliveStatusbefore], r.Dctime [30second]  
			FROM regRSMALiveStatus rs WITH(NOLOCK) 
			INNER JOIN RcDTime r WITH(NOLOCK) 
			on r.regid=rs.regId AND RegStatus='ENABLED'   AND 
			datediff(hh,rs.DCTime,getdate()) >24 AND datediff(hh,r.dctime,getdate()) <24
		)Q1 
		On v.regId=Q1.RegId   
		LEFT JOIN TicketDctNotUpdated t WITH(NOLOCK)  On v.RegId=t.Regid 
		WHERE   v.restype='1' AND v.MemberId<>142 AND ResMonEnabled=1 And
		(t.TktId is not null or  Q1.regid is not null)
		
END

SET NOCOUNT OFF




GO
