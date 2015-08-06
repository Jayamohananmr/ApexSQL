SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[USP_VMware_DeviceDown_Info]    
	@InRegId BIGINT,
	@OutAlertExist TinyInt OUTPUT
AS    
--------------------------------------------------------------------  
/*         
DECLARE @OutAlertExist TinyInt
EXEC USP_VMware_DeviceDown_Info 122,  @OutAlertExist OUTPUT
SELECT @OutAlertExist 
==============================PURPOSE==============================   
Check if Device not reporting alert exists against given regid
===============================OUTPUT==============================   
Input Para
	@InMemberID ,  
	@InUserID ,  
	@InUserType 
Ouput Para
	None

==========================PAGE NAME(CALLING)======================= 
called by exe  
==========================CREATED BY/DATE =========================  
Manali Phatak
04 Feb 2013
*/   
--------------------------------------------------------------------  


SET NOCOUNT ON  

	SELECT @OutAlertExist= (CASE WHEN COUNT(1)>0 THEN 1 ELSE 0 END)
 	FROM [30Sec_AlrtCons] WITH (NOLOCK)
	WHERE RegID=@InRegId
	


SET NOCOUNT OFF


GO
