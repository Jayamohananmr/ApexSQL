SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_NET_PubIPMon_SupServerRemove]
@InMemberID BIGINT,
@InSiteID BIGINT,
@InRegID VARCHAR(MAX),
@OutStatus INT OUTPUT
AS

/*  
==============================================================
DECLARE @OutStatus INT
EXEC [USP_NET_PubIPMon_SupServerRemove] 1,1,'1',@OutStatus OUTPUT
SELECT @OutStatus 
==================PURPOSE=====================================
To remove Public IP association if servers gets removed or uninstalled.
=====================INPUT PARAMS=============================
@InMemberID BIGINT,
@InSiteID BIGINT,
@InRegID VARCHAR(MAX)
=====================OUTPUT PARAMS============================
@OutStatus INT OUTPUT
=====================PAGE NAME(CALLING)=======================
 siteagent.aspx
=====================CREATED BY/DATE =========================    
Anamika Pandey
14th July 2014
=====================CHANGED BY/DATE =========================    
Anamika Pandey
24th July 2014
Changed datatype for @InRegID from BIGINT to VARCHAR(MAX).
=====================CHANGED BY/DATE ================
Anamika Pandey
11th August 2014
Removed UpdatedBy and UpDcdTime column from table PubIPMon_SupRegIDMapping and PubIPMon_SupRegIDMapping_History.
--------------------------------------------------------------
*/

SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS(
					SELECT 1 FROM PubIPMon_SupRegIDMapping PS WITH(NOLOCK)
					INNER JOIN RegMain R WITH(NOLOCK) ON R.RegId=PS.SupRegID 
					INNER JOIN RegRSMAliveStatus RS WITH(NOLOCK) ON RS.RegID=PS.SupRegID AND RS.RegStatus='ENABLED'
					INNER JOIN DBO.SplitText(@InRegID,',') S ON S.strData=RS.RegID  
					WHERE R.MEMBERID=@InMemberID AND R.SITEID=@InSiteID 
				 )
			BEGIN
				DELETE D 
				OUTPUT DELETED.GrpID,DELETED.SupRegID,DELETED.AddedBy,DELETED.DcdTime,GETDATE()
				INTO PubIPMon_SupRegIDMapping_History(GrpID,SupRegID,AddedBy,DcdTime,InsertedOn) 
				FROM PubIPMon_SupRegIDMapping D 
				INNER JOIN DBO.SplitText(@InRegID,',') S ON S.strData=D.SupRegID 
				
				SET @OutStatus=1
			END		 
		ELSE
			BEGIN 
				SET @OutStatus=0
			END 		  
	END TRY
	BEGIN CATCH
		SET @OutStatus=2
	END CATCH
SET NOCOUNT OFF
GO
