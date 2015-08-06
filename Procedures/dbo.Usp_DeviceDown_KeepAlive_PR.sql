SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[Usp_DeviceDown_KeepAlive_PR]  
     @InRegId bigint,
	 @OutValue numeric output 
		
 
    
as   

/* 
*/
 
set nocount on    
  
	SELECT  @OutValue= isnull(Datediff(ss,  MAX(DCTime), getdate()),-1) 
		  FROM 
		dbo.rCdTIME WITH(NOLOCK)
	WHERE REGID=@InRegId
set nocount off
GO
