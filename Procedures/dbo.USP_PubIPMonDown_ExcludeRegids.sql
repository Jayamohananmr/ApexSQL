SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_PubIPMonDown_ExcludeRegids]
@InRegID BIGINT,
@OutStatus INT OUTPUT
AS
-------------------------------------------------------------------- 
/*     
DECLARE @OutStatus INT
EXEC [USP_PubIPMonDown_ExcludeRegids] 2413614,@OutStatus OUTPUT
SELECT @OutStatus
GO
DECLARE @OutStatus INT
EXEC [USP_PubIPMonDown_ExcludeRegids] 123,@OutStatus OUTPUT
SELECT @OutStatus 
====================PURPOSE=========================
To get the suppressed regid details.     
=====================OUTPUT==========================
INPUT PARAMETERS :
	@InRegID BIGINT
OUTPUT PARAMETERS : 
	@OutStatus INT OUTPUT
=====================PAGE NAME(CALLING)==============  
Called by EXE :
AvailMonTicketCons
DeviceCommMonitoring
DeviceDown_1_5000_Check
DeviceNotReportingSiteWiseAutoTask
LinuxAvailMonAlert
LinuxDeviceDownAlert
VaultDeviceNotReachable  
=====================CREATED BY/DATE ================      
Anamika Pandey
4rth May 2015
=====================CHANGED BY/DATE ================    
Anamika Pandey
20th May 2015
Moving on Production.
*/       
--------------------------------------------------------------------  
SET NOCOUNT ON 

	DECLARE @REGSTATUS VARCHAR(20)  
	SET @REGSTATUS='ENABLED'
	
		IF EXISTS
		(
			SELECT DISTINCT R.RegID
			FROM RegMain R WITH (NOLOCK)
			INNER JOIN RegRSMAliveStatus C WITH(NOLOCK) ON C.RegID=R.REgID AND C.RegStatus=@REGSTATUS 
			INNER JOIN PubIPMon_SupRegIDMapping PS WITH(NOLOCK) ON PS.SupRegID=R.RegId  
			INNER JOIN MstPubIPMon_Group G WITH(NOLOCK) ON G.GrpID=PS.GrpID  
			INNER JOIN PubIPMon_Config PC WITH(NOLOCK) ON PC.GrpID =G.GrpID  
			INNER JOIN PubIPMon_ConfigStatus CS WITH(NOLOCK) ON CS.PubIPRegID=PC.PubIPRegID 
			WHERE R.RegId =@InRegID AND R.RegType='MSMA' AND G.IsEnabled=1 AND R.ResMonEnabled=1 
			AND CS.IPStatus <>'UP' AND ISNULL(CS.TracertDesc,'')<>''
		)
			BEGIN 	 
				SET @OutStatus=1
			END
		ELSE
			BEGIN 	 
				SET @OutStatus=0
			END	
	
SET NOCOUNT OFF
GO
