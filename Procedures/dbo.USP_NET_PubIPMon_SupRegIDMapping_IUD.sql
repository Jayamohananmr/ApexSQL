SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_NET_PubIPMon_SupRegIDMapping_IUD] 
@InMode CHAR(4),
@InGrpID VARCHAR(MAX),
@InAddSupRegId VARCHAR(MAX),
@InDelSupRegId VARCHAR(MAX),
@InAddedBy BIGINT,
@OutStatus INT OUTPUT
AS 
/*
===================EXEC================
DECLARE @OutStatus INT
EXEC [USP_NET_PubIPMon_SupRegIDMapping_IUD] 'I','28','1,2','',2301,@OutStatus OUTPUT
SELECT @OutStatus  
GO
DECLARE @OutStatus INT
EXEC [USP_NET_PubIPMon_SupRegIDMapping_IUD] 'U','28','2,3','1',2301,@OutStatus OUTPUT
SELECT @OutStatus  
GO
DECLARE @OutStatus INT
EXEC [USP_NET_PubIPMon_SupRegIDMapping_IUD] 'D','2',NULL,NULL,142325,@OutStatus OUTPUT
SELECT @OutStatus  
=====================PURPOSE========================= 
To get the list for all servers along with linux agents against Siteid and MemberID.
select * from PubIPMon_SupRegIDMapping,PubIPMon_SupRegIDMapping_History  
=====================OUTPUT========================== 
Input Parameters :
	@InMode CHAR(4),
	@InGrpID VARCHAR(MAX),
	@InAddSupRegId VARCHAR(MAX),
	@InDelSupRegId VARCHAR(MAX),
	@InAddedBy BIGINT
Output Parameters : 
	@OutStatus INT OUTPUT
=====================PAGE NAME(CALLING)==============
PubIpMon.aspx
=====================CREATED BY/DATE ================
Anamika Pandey
1th July 2014
=====================CHANGED BY/DATE ================
Anamika Pandey
11th August 2014
Removed UpdatedBy and UpDcdTime column from table PubIPMon_SupRegIDMapping and PubIPMon_SupRegIDMapping_History.
*/ 
--------------------------------------------------------------------


SET NOCOUNT ON	
	BEGIN TRY
		IF @InMode ='I' 		 
			BEGIN
				INSERT INTO PubIPMon_SupRegIDMapping(GrpID,SupRegID,AddedBy)
				SELECT @InGrpID,CAST(strData AS BIGINT)SupRegID,@InAddedBy 
				FROM DBO.SplitText(@InAddSupRegId,',') AS S  
				LEFT JOIN PubIPMon_SupRegIDMapping PS WITH(NOLOCK) ON PS.SupRegID=S.strData AND PS.GrpID=@InGrpID 
				WHERE PS.SupRegID IS NULL
			END
		IF @InMode ='U' 		 
			BEGIN	
				IF ISNULL(@InAddSupRegId,'')<>'' 
				BEGIN
					INSERT INTO PubIPMon_SupRegIDMapping(GrpID,SupRegID,AddedBy)
					
					SELECT @InGrpID,CAST(strData AS BIGINT)SupRegID,@InAddedBy 
					FROM DBO.SplitText(@InAddSupRegId,',') AS S  
					LEFT JOIN PubIPMon_SupRegIDMapping PS WITH(NOLOCK) ON PS.SupRegID=S.strData AND PS.GrpID=@InGrpID 
					WHERE PS.SupRegID IS NULL
				END
				
				IF ISNULL(@InDelSupRegId,'')<>'' 
				BEGIN
					DELETE D 
					OUTPUT DELETED.GrpID,DELETED.SupRegID,DELETED.AddedBy,DELETED.DcdTime,GETDATE()
					INTO PubIPMon_SupRegIDMapping_History(GrpID,SupRegID,AddedBy,DcdTime,InsertedOn) 
					FROM PubIPMon_SupRegIDMapping D 
					INNER JOIN DBO.SplitText(@InDelSupRegId,',') AS S ON D.SupRegID=S.strData   
					INNER JOIN DBO.SplitText(@InGrpID,',')G ON D.GrpID=G.strData 				
				END	
			END	
			
		IF @InMode ='D' 		 
		BEGIN	
			IF (@InAddSupRegId IS NULL AND @InDelSupRegId IS NULL)
				BEGIN
					DELETE D 
					OUTPUT DELETED.GrpID,DELETED.SupRegID,DELETED.AddedBy,DELETED.DcdTime,GETDATE()
					INTO PubIPMon_SupRegIDMapping_History(GrpID,SupRegID,AddedBy,DcdTime,InsertedOn) 
					FROM PubIPMon_SupRegIDMapping D 
					INNER JOIN DBO.SplitText(@InGrpID,',')G ON D.GrpID=G.strData 
				END
		END
		SET @OutStatus=1
	END TRY

	BEGIN CATCH
		SET @OutStatus=0
	END CATCH
SET NOCOUNT OFF
GO
