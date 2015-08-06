SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_Alert_RC30Sec_Cleanup]
(
  @InTicketId bigint,
  @InTableName varchar(200),
  @Outstatus int OUTPUT
)
AS
/*   
=====================EXEC STRING================= 
DECLARE @Outstatus int
EXEC [USP_Alert_RC30Sec_Cleanup] 201302280000005,'TicketDctNotUpdated',@Outstatus OUTPUT
Select @Outstatus as Outstatus 
====================PURPOSE=========================    
To Delete alert from Tickets Tables
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

BEGIN TRY

  BEGIN TRANSACTION
     
	
	IF @InTableName='TicketDctNotUpdated'
	
		BEGIN
			DELETE T
			OUTPUT DELETED.RegID, DELETED.TktID, DELETED.ExecutionDate, DELETED.CreatedDate
			INTO TicketDctNotUpdated_History(RegID, TktID, ExecutionDate, CreatedDate)
			FROM TicketDctNotUpdated T
			WHERE T.TktID=@InTicketId		
			
		END 	  	
  COMMIT TRANSACTION
  SET @Outstatus =1
END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET  @Outstatus=0
	END CATCH
	
SET NOCOUNT OFF
















GO
