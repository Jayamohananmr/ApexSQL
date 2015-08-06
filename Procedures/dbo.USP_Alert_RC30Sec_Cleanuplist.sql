SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_Alert_RC30Sec_Cleanuplist] 


AS
/*   
=====================EXEC STRING================= 
EXEC USP_Alert_RC30Sec_Cleanuplist 
====================PURPOSE=========================    
To listout all  category Tickets against appliance
=====================INPUT/OUTPUT===================  
INPUT parameter  
 none
OUTPUT parameter  
 none
=====================PAGE NAME(CALLING)============= 
Called by EXE
=====================CREATED BY/DATE ================    
Roopali
21 March 2013

*/  
SET NOCOUNT ON

	BEGIN
		
		SELECT TktID,'TicketDctNotUpdated' as TableName
		FROM TicketDctNotUpdated  WITH(NOLOCK)
		WHERE (ISNULL(TktID,0)<>0 OR TktID <>'')
		
		
	END
	
SET NOCOUNT OFF
GO
