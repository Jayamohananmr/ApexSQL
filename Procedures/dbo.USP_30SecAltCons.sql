SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[USP_30SecAltCons]      
AS     

---------------------------------------------------------
/*
=====================PURPOSE========================= 
to get the list of Ticket IDs for the date less than 10 minutes from current date
these are those tickets IDs which are proper tally with tickets from NOC
=====================OUTPUT========================== 
recordset
=====================PAGE NAME(CALLING)============== 
Ticket Management
=====================CREATED BY/DATE ================
Seema M
20/10/2007
=====================Changed BY/DATE ================

*/ 
BEGIN      
 SET NOCOUNT ON      
        
 SELECT tktid As ITSTKTID      
 FROM [30Sec_AlrtCons] WITH(NOLOCK)      
 WHERE DCDateTime<=DATEADD(MI,-10,GETDATE())      
       
 SET NOCOUNT OFF      
END    
    

GO
