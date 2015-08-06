SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE  proc [dbo].[Ticket_DevicedownCount_tot]
@jobid varchar(8000),
@Flag int =1
as
set nocount on
	if @Flag=1
		begin

			select count(Tktid) from SplitText(@jobid,',') 
			inner join   [30sec_AlrtCons]  a with(nolock)
			on strData=convert(varchar,Tktid)
			and [DateTime] <dateadd(n,-10,getdate())
		end 
	else if @Flag=2
		begin

			select Tktid from  [30sec_AlrtCons]  a with(nolock)
			where [DateTime] <dateadd(n,-10,getdate())
			
		end 
	else if @Flag=3
		begin
			select strData Tktid from SplitText(@jobid,',') 
			left outer join   [30sec_AlrtCons]  a with(nolock)
			 on strData=convert(varchar,Tktid)
			where a.Tktid is null
		end 
	else if @Flag=4
		begin
			select Count(*) Tktid from SplitText(@jobid,',') 
			left outer join   [30sec_AlrtCons]  a with(nolock)
			 on strData=convert(varchar,Tktid)
			where a.Tktid is null
		end 




GO
