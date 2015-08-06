SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_NET_PubIPMon_IPsGroup_IUD] 
@InMode CHAR(4),
@InGrpID VARCHAR(MAX)=NULL,
@InMemberID BIGINT,
@InSiteId BIGINT,
@InXmlStr VARCHAR(MAX),
@InCreatedBy BIGINT,
@OutGrpID BIGINT OUTPUT,
@OutStatus INT OUTPUT 
AS 
/*
===================EXEC================
DECLARE @OutGrpID BIGINT,@OutStatus INT   
EXEC [USP_NET_PubIPMon_IPsGroup_IUD] 'I',NULL,1,1,'<NewDataSet><IPList><IPAddress>10.2.25.25</IPAddress><FriendlyName>RMM</FriendlyName></IPList></NewDataSet>',
	1423,@OutGrpID OUTPUT,@OutStatus OUTPUT  
SELECT @OutGrpID AS GrpID,@OutStatus Status  
GO
DECLARE @OutGrpID BIGINT ,@OutStatus INT 
EXEC [USP_NET_PubIPMon_IPsGroup_IUD] 'U',1,1,1,'<NewDataSet><IPList><IPAddress>10.2.25.25</IPAddress><FriendlyName>RMM</FriendlyName></IPList></NewDataSet>',
	2301,@OutGrpID OUTPUT,@OutStatus OUTPUT   
SELECT @OutGrpID AS GrpID ,@OutStatus Status 
GO
DECLARE @OutGrpID BIGINT ,@OutStatus INT 
EXEC [USP_NET_PubIPMon_IPsGroup_IUD] 'D','3',1,1,NULL,2300,@OutGrpID OUTPUT,@OutStatus OUTPUT   
SELECT @OutGrpID AS GrpID ,@OutStatus Status 
=====================PURPOSE========================= 
To create a new group against a member and site  for Public IP Monitoring.
Table : MstPubIPMon_Group,MstPubIPMon_Group_History
=====================OUTPUT========================== 
INPUT PARAMETERS : 
	@InMode CHAR(4),
	@InGrpID BIGINT=NULL,
	@InMemberID BIGINT,
	@InSiteId BIGINT,
	@InXmlStr VARCHAR(MAX),
	@InCreatedBy BIGINT
OUTPUT PARAMETERS :
	@OutGrpID BIGINT OUTPUT
=====================PAGE NAME(CALLING)==============
PubIpMon.aspx 
=====================CREATED BY/DATE ================
Anamika Pandey
26/06/2014
=====================MODIFIED BY/DATE================
Khushbu Sharma
21/01/2015
Added column IsMGMTUser,Reason
*/ 
--------------------------------------------------------------------


SET NOCOUNT ON	
BEGIN TRY
	IF @InMode='I'
	BEGIN
		INSERT INTO MstPubIPMon_Group(MemberID,SiteID,XmlStr,CreatedBy) 
		SELECT @InMemberID,@InSiteId,@InXmlStr,@InCreatedBy 
		
		SET @OutGrpID =@@IDENTITY 
	END	 	
	
	IF @InMode='U'
	BEGIN
		UPDATE PG 
		SET PG.XmlStr=@InXmlStr, 
			PG.UpdatedBy=@InCreatedBy,
			PG.UpDcdTime=GETDATE()
		OUTPUT DELETED.GrpID,DELETED.MemberID,DELETED.SiteID,DELETED.XmlStr,DELETED.CreatedBy,DELETED.UpdatedBy,
			   DELETED.DcdTime,DELETED.UpDcdTime,GETDATE(),DELETED.IsEnabled,DELETED.IsMGMTUser,DELETED.Reason   	 	
		INTO MstPubIPMon_Group_History(GrpID,MemberID,SiteID,XmlStr,CreatedBy,UpdatedBy,DcdTime,UpDcdTime,
				InsertedOn,IsEnabled,IsMGMTUser,Reason ) 	   
		FROM MstPubIPMon_Group PG
		INNER JOIN DBO.SplitText(@InGrpID,',') S ON PG.GrpID=S.strData  	
		WHERE PG.MemberID=@InMemberID AND PG.SiteID=@InSiteId 
		
		SET @OutGrpID =@InGrpID 
	END
	
	IF @InMode='D'  
	BEGIN
		UPDATE PG 
		SET PG.IsEnabled=0, 
			PG.UpdatedBy=@InCreatedBy,
			PG.UpDcdTime=GETDATE()
		OUTPUT DELETED.GrpID,DELETED.MemberID,DELETED.SiteID,DELETED.XmlStr,DELETED.CreatedBy,DELETED.UpdatedBy,
			   DELETED.DcdTime,DELETED.UpDcdTime,GETDATE(),DELETED.IsEnabled,DELETED.IsMGMTUser,DELETED.Reason  	 	
		INTO MstPubIPMon_Group_History(GrpID,MemberID,SiteID,XmlStr,CreatedBy,UpdatedBy,DcdTime,UpDcdTime,
				InsertedOn,IsEnabled,IsMGMTUser,Reason ) 	   
		FROM MstPubIPMon_Group PG
		INNER JOIN DBO.SplitText(@InGrpID,',') S ON PG.GrpID=S.strData  	
		WHERE  PG.MemberID=@InMemberID AND PG.SiteID=@InSiteId 	
		
		SET @OutGrpID=0
	END 
	SET @OutStatus=1
END TRY

BEGIN CATCH
	SET @OutGrpID=0
	SET @OutStatus=0
END CATCH
SET NOCOUNT OFF


GO
