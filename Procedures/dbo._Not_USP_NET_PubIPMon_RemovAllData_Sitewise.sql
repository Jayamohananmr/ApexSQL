SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_NET_PubIPMon_RemovAllData_Sitewise]
@InMemberID BIGINT, 
@InSiteID BIGINT ,
@OutStatus INT OUTPUT
AS
--------------------------------------------------------------------  
/*     
DECLARE @OutStatus INT 
EXEC [USP_NET_PubIPMon_RemovAllData_Sitewise] 1,113,@OutStatus OUTPUT
SELECT @OutStatus
====================PURPOSE=========================
To perform public IP cleanup process if Site gets removed from Portal.     
=====================OUTPUT==========================
INPUT PARAMETERS :
	@InMemberID BIGINT, 
	@InSiteID BIGINT
OUTPUT PARAMETERS : 
	@OutStatus INT OUTPUT
=====================PAGE NAME(CALLING)==============  
 
=====================CREATED BY/DATE ================      
Anamika Pandey
15th July 2014
*/       
--------------------------------------------------------------------  
SET NOCOUNT ON
	 BEGIN TRY
		 BEGIN
			DECLARE @InGrpID VARCHAR(MAX),@InPubIPRegID VARCHAR(MAX) 

			--------------------
			SELECT @InGrpID = COALESCE (@InGrpID + ',' ,'') + CONVERT(VARCHAR,ISNULL(GrpID,0)) 
			FROM MstPubIPMon_Group WITH(NOLOCK)
			WHERE MemberID=@InMemberID AND SiteID=@InSiteID 

			SELECT @InPubIPRegID = COALESCE (@InPubIPRegID + ',' ,'') + CONVERT(VARCHAR,ISNULL(P.PubIPRegID  ,0)) 
			FROM PubIPMon_Config P WITH(NOLOCK)
			INNER JOIN dbo.SplitText(@InGrpID,',') S ON S.strData=P.GrpID 

			----------------Delete data from PubIPMon_ConfigSts_Cons 
			DELETE P
			OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.PubIPRegID,DELETED.PubIPAddrss,DELETED.ConditionID,
				   DELETED.TaskRawID,DELETED.DcDtime,DELETED.UpDcDtime,GETDATE() 
			INTO PubIPMon_ConfigSts_Cons_History(MemberID,SiteID,PubIPRegID,PubIPAddrss,ConditionID,
				 TaskRawID,DcDtime,UpDcDtime,InsertedOn) 	   
			FROM PubIPMon_ConfigSts_Cons P
			WHERE P.MemberID=@InMemberID AND P.SiteID=@InSiteID 

			----------------Delete data from PubIPMon_SupRegIDMapping
			DELETE P
			OUTPUT DELETED.GrpID,DELETED.SupRegID,DELETED.AddedBy,DELETED.DcdTime,GETDATE()
			INTO PubIPMon_SupRegIDMapping_History(GrpID,SupRegID,AddedBy,DcdTime,InsertedOn) 
			FROM PubIPMon_SupRegIDMapping P WITH(NOLOCK) 
			INNER JOIN dbo.SplitText(@InGrpID,',') S ON S.strData=P.GrpID 

			----------------Update records as Remove/Uninstall in PubIPMon_Lookup and also in table RegRSMAliveStatus
			UPDATE R
			SET RegStatus='UNINSTALL',
				UnInstDate=GETDATE()
			FROM RegRSMAliveStatus R 
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=R.RegId 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			
			UPDATE P 
			SET ActionTkn='Remove',
				UpDcdTime=GETDATE(),
				IsProcessed=0
			FROM PubIPMon_Lookup P
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=P.PubIPRegID 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  

			----------------Delete data from PubIPMon_ConfigStatus
			DELETE P
			OUTPUT DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.IPStatus,DELETED.ErrCode,DELETED.ErrDesc,
				   DELETED.TracertDesc,DELETED.DcdTime,DELETED.UpDcdTime,GETDATE() 
			INTO PubIPMon_ConfigStatus_History(PubIPRegID,PubIPAddrs,IPStatus,ErrCode,ErrDesc,
				 TracertDesc,DcdTime,UpDcdTime,InsertedOn) 	   
			FROM PubIPMon_ConfigStatus P WITH(NOLOCK) 
			INNER JOIN dbo.SplitText(@InPubIPRegID,',') S ON S.strData=P.PubIPRegID  

			----------------Delete data from PubIPMon_Config
			DELETE P
			OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.GrpID,DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.FrndlyName,
				   DELETED.SetAlert,DELETED.DcdTime,DELETED.UpDcdTime,GETDATE()
			INTO PubIPMon_Config_History(MemberID,SiteID,GrpID,PubIPRegID,PubIPAddrs,FrndlyName,SetAlert,DcdTime,UpDcdTime,InsertedOn) 	   
			FROM PubIPMon_Config P WITH(NOLOCK) 
			INNER JOIN dbo.SplitText(@InPubIPRegID,',') S ON S.strData=P.PubIPRegID  

			----------------Delete data from MstPubIPMon_Group
			DELETE P
			OUTPUT DELETED.GrpID,DELETED.MemberID,DELETED.SiteID,DELETED.XmlStr,DELETED.CreatedBy,
				   DELETED.UpdatedBy,DELETED.DcdTime,DELETED.UpDcdTime,GETDATE(),DELETED.IsEnabled
			INTO MstPubIPMon_Group_History(GrpID,MemberID,SiteID,XmlStr,CreatedBy,
				 UpdatedBy,DcdTime,UpDcdTime,InsertedOn,IsEnabled) 
			FROM MstPubIPMon_Group P WITH(NOLOCK) 
			INNER JOIN dbo.SplitText(@InGrpID,',') S ON S.strData=P.GrpID 
		END
		SET @OutStatus=1
	END TRY
	BEGIN CATCH
		SET @OutStatus=0
	END CATCH
SET NOCOUNT OFF
GO
