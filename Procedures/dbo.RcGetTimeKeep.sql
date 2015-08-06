SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[RcGetTimeKeep]          
 @InRegID Bigint ,
 @OutValue Bigint output
  
AS          

/*
USING IN NAS SERVER PROVISIONG REPORT
SHOWING SERVER LIVE OR NOT

*/
SET NOCOUNT ON   
	

		SELECT  @OutValue=Datediff(ss, DCTime, getdate())  
			FROM RcDTime WITH(NOLOCK) where regid=@InRegID
   
SET NOCOUNT OFF 



GO
