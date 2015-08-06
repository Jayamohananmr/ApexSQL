SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[RcGetTimeMin]          
 @InRegID Bigint ,
 @OutMin bigint output
  
AS          

SET NOCOUNT ON   
	Set @OutMin=-1


		SELECT @OutMin=  Datediff(mi, DCTime, getdate()) 
			FROM RcDTime WITH(NOLOCK) where regid=@InRegID
   
  
SET NOCOUNT OFF
GO
