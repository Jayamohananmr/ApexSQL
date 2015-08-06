SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[RcGetTimeAllRegid]          
  
AS          

SET NOCOUNT ON   
	

		SELECT regid,Datediff(ss, DCTime, getdate()) AliveSec,DCTime 
			FROM RcDTime WITH(NOLOCK) 
  
   GOTO SUCCESS  
  
SUCCESS:  
  
SET NOCOUNT OFF 




GO
