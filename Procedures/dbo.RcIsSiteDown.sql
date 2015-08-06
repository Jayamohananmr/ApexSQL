SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------

declare @op bigint
exec RcIsSiteDown 807,240,@op output
print @op
-------------------------------------------------*/

CREATE  PROCEDURE [dbo].[RcIsSiteDown]          
 	@InSiteD Bigint ,
	@InThSec bigint,
	@OutRegOnlineCnt bigint output
  
AS          

SET NOCOUNT ON   
	

	SELECT @OutRegOnlineCnt = count(V.REGID) 
	FROM REGMAIN V WITH(NOLOCK)
		INNER JOIN REGRSMALIVESTATUS ST WITH(NOLOCK)
		ON ST.REGID=V.REGID AND ST.REGSTATUS='ENABLED'
	Inner JOIN RcDTime RC WITH(NOLOCK) ON RC.REGID=V.REGID
	WHERE V.PARENTID IS NULL and V.SiteID = @InSiteD
	and Datediff(ss, RC.Dctime, getdate()) - @InThSec <= 0  
  
SET NOCOUNT OFF 




GO
