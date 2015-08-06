SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_TicketDctNotUpdated_IUD]
	@INRegID bigint,
	@INTktid bigint,
	@InOpt int, -- 1 for Update/insert, 2 for delete
	@Outret int OUTPUT
AS

--------------------------------------------------------------------  
/*         

DECLARE @Outret int
EXEC USP_TicketDctNotUpdated_IUD 2,201302280000002,1,@Outret OUTPUT
select @Outret
==============================Page Name ==============================  
Called by exe DCtimeNotRecd
==============================PURPOSE==============================   
Update/Insert data into TicketDctNotUpdated or Delete data from TicketDctNotUpdated
===============================OUTPUT==============================   
Input Para
	@INRegID ,
	@INTktid ,
	@InOpt

Ouput Para
	@Outret 

==========================PAGE NAME(CALLING)=======================   
==========================CREATED BY/DATE =========================  
Deepesh Joshi
3/5/2008
==========================CHANGED BY/DATE =========================  
Roopali pandey
28/02/2013
Added set @Outret=1 in option 1

*/   
--------------------------------------------------------------------  

SET NOCOUNT ON

	Declare @err bigint, @rcount bigint
 


	IF @InOpt=1

		BEGIN 

			UPDATE TicketDctNotUpdated SET Executiondate=getdate()
			WHERE RegID=@INRegID AND Tktid=@INTktid

			SET @rcount=@@ROWCOUNT

			IF @rcount=0
				BEGIN
					INSERT INTO TicketDctNotUpdated (TktID,RegID,Executiondate)
							VALUES (@INTktid,@INRegID,GETDATE())

					SELECT @err=@@ERROR , @rcount=@@ROWCOUNT
			
					IF @err<>0  
						BEGIN
						
							SET @Outret=0
						END
					ELSE
						BEGIN
							SET @Outret=1
						END
				END
				
			SET @Outret=1
				
		END 

	ELSE IF @InOpt=2

		BEGIN 

			DELETE TicketDctNotUpdated WHERE RegID=@INRegID AND Tktid=@INTktid

			SELECT @err=@@ERROR , @rcount=@@ROWCOUNT

			IF @err<>0  
				BEGIN
					SET @Outret=0
				END
			ELSE
				BEGIN
					SET @Outret=1
				END

		END
		 
SET NOCOUNT OFF
GO
