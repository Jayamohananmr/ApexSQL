SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



create  PROCEDURE [dbo].[RcGetTime]          
 @InRegID Bigint 
  
AS          

SET NOCOUNT ON   
	

		SELECT regid,Datediff(ss, DCTime, getdate()) AliveSec,DCTime 
			FROM RcDTime WITH(NOLOCK) where regid=@InRegID
  
   GOTO SUCCESS  
  
SUCCESS:  
  
SET NOCOUNT OFF 




GO
