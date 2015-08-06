SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_PubIPMonDown_IUD]
@InStatus VARCHAR(20), 
@InMemberID BIGINT,
@InSiteID BIGINT,
@InPubIPRegID BIGINT,
@InPubIPAddrss VARCHAR(100),
@InConditionID BIGINT,
@InTaskRawID VARCHAR(100),
@OutStatus INT OUTPUT
AS
/*   
=====================EXEC STRING================= 
DECLARE @OutStatus INT 
EXEC [USP_PubIPMonDown_IUD] 'NEW',1,1,3,'10.36.30.70',1,'MD201407100000001',@OutStatus OUTPUT
SELECT @OutStatus AS OutStatus

DECLARE @OutStatus INT 
EXEC [USP_PubIPMonDown_IUD] 'UPDATE',1,1,3,'10.36.30.70',1,'MD201407100000002',@OutStatus OUTPUT
SELECT @OutStatus AS OutStatus

DECLARE @OutStatus INT 
EXEC [USP_PubIPMonDown_IUD] 'CLOSE',1,1,3,'10.36.30.70',1,'MD201407100000001',@OutStatus OUTPUT
SELECT @OutStatus AS OutStatus

DECLARE @OutStatus INT 
EXEC [USP_PubIPMonDown_IUD] 'FULLCLOSE',1,1,3,'10.36.30.70',1,'MD201407100000001',@OutStatus OUTPUT
SELECT @OutStatus AS OutStatus
====================PURPOSE=========================    
To insert/update/delete in consolidation table:PubIPMon_ConfigSts_Cons for Public IP Monitoring Down.
=====================INPUT/OUTPUT===================  
INPUT parameter  
	@InStatus VARCHAR(20), 
	@InMemberID BIGINT,
	@InSiteID BIGINT,
	@InPubIPRegID BIGINT,
	@InPubIPAddrss VARCHAR(100),
	@InConditionID BIGINT,
	@InTaskRawID VARCHAR(100)
OUTPUT parameter  
	@OutStatus INT OUTPUT
=====================PAGE NAME(CALLING)==============
Called By EXE :  
=====================CREATED BY/DATE ================    
Anamika Pandey
10th July 2014
*/ 

SET NOCOUNT ON

DECLARE @CNT INT
BEGIN TRY
	BEGIN
		IF @InStatus='NEW'
			BEGIN
				INSERT INTO PubIPMon_ConfigSts_Cons(MemberID,SiteID,PubIPRegID,PubIPAddrss,ConditionID,TaskRawID) 
				SELECT @InMemberID,@InSiteID,@InPubIPRegID,@InPubIPAddrss,@InConditionID,@InTaskRawID 
			END
		IF @InStatus='UPDATE'
			BEGIN
				UPDATE A
				SET A.TaskRawID=@InTaskRawID,
					A.UpDcDtime=GETDATE()
				OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.PubIPRegID,DELETED.PubIPAddrss,DELETED.ConditionID,
					   DELETED.TaskRawID,DELETED.DcDtime,DELETED.UpDcDtime,GETDATE() 	 
				INTO PubIPMon_ConfigSts_Cons_History(MemberID,SiteID,PubIPRegID,PubIPAddrss,ConditionID,TaskRawID,DcDtime,UpDcDtime,InsertedOn) 
				FROM PubIPMon_ConfigSts_Cons A
				WHERE A.MemberID=@InMemberID AND A.SiteID=@InSiteID AND A.PubIPRegID=@InPubIPRegID AND A.ConditionID=@InConditionID 
				
				SET @CNT=@@ROWCOUNT
				
				IF @CNT=0
				BEGIN
					INSERT INTO PubIPMon_ConfigSts_Cons(MemberID,SiteID,PubIPRegID,PubIPAddrss,ConditionID,TaskRawID) 
					SELECT @InMemberID,@InSiteID,@InPubIPRegID,@InPubIPAddrss,@InConditionID,@InTaskRawID 
				END
				
				/*If any new Regid comes with issue and application not getting updates for old once then update all records with new TaskRawID
				as a site can have only one TaskRawID*/

				UPDATE A
				SET A.TaskRawID=@InTaskRawID,
					A.UpDcDtime=GETDATE()
				--OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.PubIPRegID,DELETED.PubIPAddrss,DELETED.ConditionID,
				--	   DELETED.TaskRawID,DELETED.DcDtime,DELETED.UpDcDtime,GETDATE() 	 
				--INTO PubIPMon_ConfigSts_Cons_History(MemberID,SiteID,PubIPRegID,PubIPAddrss,ConditionID,TaskRawID,DcDtime,UpDcDtime,InsertedOn) 
				FROM PubIPMon_ConfigSts_Cons A
				WHERE A.MemberID=@InMemberID AND A.SiteID=@InSiteID
			END	
		IF @InStatus='CLOSE'
			BEGIN
				DELETE A
				OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.PubIPRegID,DELETED.PubIPAddrss,DELETED.ConditionID,
					   DELETED.TaskRawID,DELETED.DcDtime,DELETED.UpDcDtime,GETDATE() 	 
				INTO PubIPMon_ConfigSts_Cons_History(MemberID,SiteID,PubIPRegID,PubIPAddrss,ConditionID,TaskRawID,DcDtime,UpDcDtime,InsertedOn) 
				FROM PubIPMon_ConfigSts_Cons A
				WHERE A.MemberID=@InMemberID AND A.SiteID=@InSiteID AND A.PubIPRegID=@InPubIPRegID AND A.ConditionID=@InConditionID 
			END
		IF @InStatus='FULLCLOSE' /*Block added as in case if Partner has closed any ticket and the ticket is in close mode in 
								   NOC DB then remove entry from Consolidation table to generate fresh ticket against that partner*/
			BEGIN
				DELETE A
				OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.PubIPRegID,DELETED.PubIPAddrss,DELETED.ConditionID,
					   DELETED.TaskRawID,DELETED.DcDtime,DELETED.UpDcDtime,GETDATE() 	 
				INTO PubIPMon_ConfigSts_Cons_History(MemberID,SiteID,PubIPRegID,PubIPAddrss,ConditionID,TaskRawID,DcDtime,UpDcDtime,InsertedOn) 
				FROM PubIPMon_ConfigSts_Cons A
				WHERE A.MemberID=@InMemberID AND A.SiteID=@InSiteID AND A.ConditionID=@InConditionID 
			END	
		END
	SET @OutStatus=1
END TRY

BEGIN CATCH
	SET @OutStatus=0
END CATCH		
		
SET NOCOUNT OFF
GO
