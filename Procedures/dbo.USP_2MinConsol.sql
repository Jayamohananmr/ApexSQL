SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE    PROCEDURE [dbo].[USP_2MinConsol]      
 @InRegID Bigint,
 @OutStatus Varchar(50) OutPut ,
 @OutResName Varchar(300) OutPut ,
 @OutTktId Bigint OutPut ,
 @OutResFriendlyName Varchar(100)=NULL OutPut  
AS  



/*

 
declare @OutStatus Varchar(50)
declare @OutResName Varchar(300)
declare @OutTktId Bigint 
declare @OutResFriendlyName Varchar(100)
exec USP_2MinConsol 185172,@OutStatus output,@OutResName output,@OutTktId output,@OutResFriendlyName output
select @OutStatus AS OutStatus, @OutResName as OutResName  ,@OutTktId as OutTktId ,@OutResFriendlyName as OutResFriendlyName 


-- =============================================
-- Description:	Using In  30SecRc Database
-- For As Per Remote user Request Sending Code to Server and Updating RcDtime Field When its Given To Server
=====================CREATED BY/DATE ================
Vishal Bhor
07 Aug 2012
Added  ResFriendlyName in select claues. 
*/
    

SET NOCOUNT ON      
		
	
	SELECT @OutStatus=isnull(case when d.regid is not null then 'GOOD' else h.Status end,'NC') 
	,@OutTktId=isnull(h.Tktid,0)
	,@OutResName=r.ResourceName 
	,@OutResFriendlyName = r.ResFriendlyName
	FROM [Regmain] r  with (nolock)
	left join [HTTPSTunnel_AlrtCons] h  with (nolock) on h.regid = r.regid 
	left join [30Sec_AlrtCons] d  with (nolock) on d.regid = r.regid 
	where r.RegId=@InRegID

SET NOCOUNT OFF


GO
