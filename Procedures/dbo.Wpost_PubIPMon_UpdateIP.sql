SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Wpost_PubIPMon_UpdateIP]
@InPubIPRegID VARCHAR(MAX),
@OutStatus INT OUTPUT
AS
/*
===================EXEC================
DECLARE @OutStatus INT 
EXEC  [Wpost_PubIPMon_UpdateIP] '2414854,2414855,2414860,2414861,2414862,2414863',@OutStatus OUTPUT  
SELECT @OutStatus
=====================PURPOSE========================= 
To update the status of IP's that are parsed successfully.
=====================OUTPUT========================== 

=====================PAGE NAME(CALLING)==============
Called by Wpost 
=====================CREATED BY/DATE ================
Anamika Pandey
17th July 2014
=====================CHANGED BY/DATE ================
Anamika Pandey
11th August 2014
Handled @OutStatus value if any update happend then only set else mark as 0.
*/ 
--------------------------------------------------------------------

SET NOCOUNT ON
	BEGIN TRY
		DECLARE @CNT BIGINT
		SET @OutStatus=0 
		SET @CNT=0 
		
		UPDATE P
		SET IsProcessed=1,
			UpDcdTime=GETDATE()
		FROM PubIPMon_Lookup P
		INNER JOIN dbo.SplitText(@InPubIPRegID,',') AS S ON S.strData=P.PubIPRegID 
		
		SET @CNT=@@ROWCOUNT 
		
		IF @CNT > 0
		BEGIN
			SET @OutStatus=1  
		END	
	END TRY

	BEGIN CATCH
		SET @OutStatus=0
	END CATCH
SET NOCOUNT OFF
GO
