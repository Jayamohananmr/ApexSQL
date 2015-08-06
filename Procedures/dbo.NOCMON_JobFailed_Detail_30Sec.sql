SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- /*===================================================================================
-- SP Name           : NOCMON_JobFailed_Detail_30Sec
-- Created By        : Abhishek
-- Created Date      : 02-nov-2007
-- --------------------------------------------------------------------------------------
-- Gui Option        : 	nocmon->Reports->Ticket Reports
-- Call From         :  NOCMON/frmFailedJobReport.asp
-- Exes              : 	None.
--===================================================================================
-- Updated By        : 	Abhishek
-- Updated Date      : 	02-nov-2007
-- Purpose           : 		This sp returns detail of Tickets Which are Failed in geneation.
-- 				It has parameter named as @jobid ,which holds multiple jobid with comma
--				seperated, which will be searched in table named as 30Sec_AlrtCons.
--Database 	     : 30SecRc
--===================================================================================*/  

CREATE  proc NOCMON_JobFailed_Detail_30Sec
	@jobid varchar(8000)
as
		select Regid,Tktid,[Datetime],ThresholdCounter,status,JobPostStatus from Splittext(@jobid,',') 
		inner join   [30Sec_AlrtCons]   a with(nolock)
		on strData=convert(varchar,Tktid)  




GO
