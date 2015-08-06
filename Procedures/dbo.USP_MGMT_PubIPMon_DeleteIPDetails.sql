SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_MGMT_PubIPMon_DeleteIPDetails]
@InMemberID BIGINT,  
@InSiteId BIGINT,  
@InCreatedBy BIGINT, 
@InReason VARCHAR(2000), 
@OutStatus INT OUTPUT   
AS
/*  
==============================================================
Declare @OutStatus INT
exec [USP_MGMT_PubIPMon_DeleteIPDetails] 1,114761,85,'test',@OutStatus output
select @OutStatus
==================PURPOSE=====================================
To delete IP Details.
=====================INPUT PARAMS=============================
@InMemberID BIGINT,  
@InSiteId BIGINT,  
@InCreatedBy BIGINT,  
=====================OUTPUT PARAMS============================
RecordSet
=====================PAGE NAME(CALLING)=======================
Bil_Mark_Ac_Disable_NetworkIP_Report.asp
=====================CREATED BY/DATE =========================    
Khushbu Sharma
29th Dec 2014
=====================MODIFIED BY/DATE =========================    
Khushbu Sharma
8th Jan 2015
Added REASON column in sp
--------------------------------------------------------------
*/
SET NOCOUNT ON 

	DECLARE @GrpID  VARCHAR(MAX)
				
	SELECT @GrpID = COALESCE(@GrpID + ',', '') + CAST(MG.GRPID AS VARCHAR)
	FROM PubIPMon_Config PC WITH(NOLOCK)
	INNER JOIN RegRSMAliveStatus RS WITH(NOLOCK) ON RS.RegId=PC.PubIPRegID AND RS.RegStatus='ENABLED'
	INNER JOIN MstPubIPMon_Group MG WITH(NOLOCK) ON MG.GrpID=PC.GrpID AND MG.IsEnabled=1
	INNER JOIN PubIPMon_Lookup PL WITH(NOLOCK) ON PL.PubIPRegID=PC.PubIPRegID AND PL.GrpID=PC.GrpID AND PL.ActionTkn='ADD' 
	WHERE PC.MemberID=@InMemberID AND PC.SiteID=@InSiteId
			
	BEGIN TRY  
		BEGIN
			DELETE D 
			OUTPUT DELETED.GrpID,DELETED.SupRegID,DELETED.AddedBy,DELETED.DcdTime,GETDATE()
			INTO PubIPMon_SupRegIDMapping_History(GrpID,SupRegID,AddedBy,DcdTime,InsertedOn) 
			FROM PubIPMon_SupRegIDMapping D 
			INNER JOIN DBO.SplitText(@GrpID,',')G ON D.GrpID=G.strData 
			--------------------------------------------------------------------------
			
			UPDATE R
			SET RegStatus='UNINSTALL',
				UnInstDate=GETDATE()
			FROM RegRSMAliveStatus R 
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=R.RegId 
			INNER JOIN DBO.SplitText(@GrpID,',') S ON IP.GrpID=S.strData  

			--------------------------------------------------------------------------
			
			UPDATE P 
			SET ActionTkn='Remove',
				UpDcdTime=GETDATE(),
				IsProcessed=0
			FROM PubIPMon_Lookup P
			INNER JOIN DBO.SplitText(@GrpID,',') S ON P.GrpID=S.strData  
			
			--------------------------------------------------------------------------
			
			DELETE IP  
			OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.GrpID,DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.FrndlyName,
				DELETED.SetAlert,DELETED.DcdTime,DELETED.UpDcdTime,GETDATE()
			INTO PubIPMon_Config_History(MemberID,SiteID,GrpID,PubIPRegID,PubIPAddrs,FrndlyName,SetAlert,DcdTime,UpDcdTime,InsertedOn)			   
			FROM PubIPMon_Config IP
			INNER JOIN DBO.SplitText(@GrpID,',') S ON IP.GrpID=S.strData  
			
			--------------------------------------------------------------------------
			UPDATE PG 
			SET PG.IsEnabled=0, 
				PG.UpdatedBy=@InCreatedBy,
				PG.UpDcdTime=GETDATE(),
				PG.ISMGMTUSER=1,
				PG.REASON=@InReason
			OUTPUT DELETED.GrpID,DELETED.MemberID,DELETED.SiteID,DELETED.XmlStr,DELETED.CreatedBy,DELETED.UpdatedBy,
				   DELETED.DcdTime,DELETED.UpDcdTime,DELETED.IsEnabled,DELETED.ISMGMTUSER,DELETED.REASON
			INTO MstPubIPMon_Group_History(GrpID,MemberID,SiteID,XmlStr,CreatedBy,UpdatedBy,DcdTime,UpDcdTime,IsEnabled,ISMGMTUSER,REASON) 	   
			FROM MstPubIPMon_Group PG
			INNER JOIN DBO.SplitText(@GrpID,',') S ON PG.GrpID=S.strData  	
			WHERE  PG.MemberID=@InMemberID AND PG.SiteID=@InSiteId 	
			
			--------------------------------------------------------------------------

			SET @OutStatus=1
		END		
	END TRY

	BEGIN CATCH
		SET @OutStatus=0
	END CATCH
	
SET NOCOUNT OFF


GO
