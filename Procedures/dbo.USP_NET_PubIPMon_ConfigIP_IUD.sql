SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_NET_PubIPMon_ConfigIP_IUD]
@InMode	VARCHAR(10), 
@InMemberID BIGINT,
@InSiteID BIGINT,
@InGrpID VARCHAR(MAX),
@InXml VARCHAR(MAX)=NULL,
@InSetAlert BIT,
@OutStatus INT OUTPUT
AS

/*  
==============================================================
DECLARE @OutStatus INT
EXEC [USP_NET_PubIPMon_ConfigIP_IUD] 'I',1,1,'2',
'<NewDataSet>  
  <Table>  
   <GrpID>2</GrpID>  
   <RegId>2414416</RegId>   
   <IPAddress>10.10.10.50</IPAddress>  
   <FriendlyName>Public IP1</FriendlyName>  
  </Table>  
</NewDataSet>',1,@OutStatus OUTPUT
SELECT @OutStatus
GO
DECLARE @OutStatus INT
EXEC [USP_NET_PubIPMon_ConfigIP_IUD] 'U',1,1,'4',
'<NewDataSet>  
  <Table>  
   <GrpID>4</GrpID>  
   <RegId>2414414</RegId>   
   <IPAddress>10.2.10.5</IPAddress>  
   <FriendlyName>Public IP1</FriendlyName>  
  </Table>  
  <Table>  
   <GrpID>4</GrpID>  
   <RegId>2414415</RegId>   
   <IPAddress>10.20.30.41</IPAddress>  
   <FriendlyName>Public IP2</FriendlyName>  
  </Table>  
   <Table>  
   <GrpID>4</GrpID>  
   <RegId>2414428</RegId>   
   <IPAddress>11.22.33.44</IPAddress>  
   <FriendlyName>IP121</FriendlyName>  
  </Table> 
</NewDataSet>',1,@OutStatus OUTPUT
SELECT @OutStatus
GO
DECLARE @OutStatus INT
EXEC [USP_NET_PubIPMon_ConfigIP_IUD] 'D',1,1,'4',
'<NewDataSet>  
  <Table>  
   <GrpID>4</GrpID>  
   <RegId>2414414</RegId>   
   <IPAddress>10.2.10.5</IPAddress>  
   <FriendlyName>Public IP1</FriendlyName>  
  </Table>  
  <Table>  
   <GrpID>4</GrpID>  
   <RegId>2414415</RegId>   
   <IPAddress>10.20.30.41</IPAddress>  
   <FriendlyName>Public IP2</FriendlyName>  
  </Table>  
   <Table>  
   <GrpID>4</GrpID>  
   <RegId>2414417</RegId>   
   <IPAddress>10.30.78.23</IPAddress>  
   <FriendlyName>Public IP4</FriendlyName>  
  </Table> 
</NewDataSet>',1,@OutStatus OUTPUT
SELECT @OutStatus
GO 
==================PURPOSE=====================================
To perform Insert/Update and Delete from tables  : PubIPMon_Config,PubIPMon_Config_History,PubIPMon_Lookup
=====================INPUT PARAMS=============================
@InMode	VARCHAR(10), 
@InMemberID BIGINT,
@InSiteID BIGINT,
@InGrpID VARCHAR(MAX),
@InXml  VARCHAR(MAX)
=====================OUTPUT PARAMS============================
@OutStatus INT OUTPUT
=====================PAGE NAME(CALLING)=======================
PubIpMon.aspx
=====================CREATED BY/DATE =========================    
Anamika Pandey
18th June 2014
=====================CHANGED BY/DATE =========================    
Anamika Pandey
11th August 2014
Added code to update IsProcessed column as 0 while Remove entry from main tables.
=====================CHANGED BY/DATE =========================    
Anamika Pandey
22th August 2014
Added code to remove entry from PubIPMon_ConfigStatus table in case of IP remove.
------------------------------------------------------------
*/

SET NOCOUNT ON
	BEGIN TRY
	DECLARE @XmlStr XML
	SET @XmlStr=CAST(@InXml AS XML) 

	CREATE TABLE #IPDetails
	(
		GrpID BIGINT,
		RegId BIGINT,
		IPAddress VARCHAR(100),
		FriendlyName VARCHAR(100)
	)
	
	INSERT INTO #IPDetails(GrpID,RegId,IPAddress,FriendlyName) 
	SELECT field.value('GrpID[1]','bigint') AS GrpID,
		   field.value('RegId[1]','bigint') AS RegId,
		   field.value('IPAddress[1]','varchar(100)') AS IPAddress,
		   field.value('FriendlyName[1]','varchar(100)') AS FriendlyName
	FROM @XmlStr.nodes('/NewDataSet/Table') AS a(field)
	------------------------------------------------------------------------
	IF @InMode='I'
		BEGIN
			INSERT INTO PubIPMon_Config(MemberID,SiteID,GrpID,PubIPRegID,PubIPAddrs,FrndlyName,SetAlert) 
			SELECT @InMemberID,@InSiteID,S.strData,A.RegId,A.IPAddress,A.FriendlyName,@InSetAlert  
			FROM #IPDetails A
			INNER JOIN dbo.SplitText(@InGrpID,',') AS S ON A.GrpID=S.strData 
			LEFT JOIN PubIPMon_Config PC WITH(NOLOCK) ON PC.PubIPRegID=A.RegId 
			WHERE PC.PubIPRegID IS NULL
			
			INSERT INTO PubIPMon_Lookup(GrpID,PubIPRegID,PubIPAddrs,ActionTkn,DcdTime) 
			SELECT S.strData,A.RegId,A.IPAddress,'Add',GETDATE()
			FROM #IPDetails A 
			INNER JOIN dbo.SplitText(@InGrpID,',') AS S ON S.strData=A.GrpID  
			LEFT JOIN PubIPMon_Lookup PL WITH(NOLOCK) ON PL.PubIPRegID=A.RegId AND PL.ActionTkn='Add'
			WHERE PL.PubIPRegID IS NULL
		END
	ELSE IF @InMode='U'
		BEGIN
			----------Update existing records in all below mentioned tables-------------
			UPDATE IP
			SET IP.FrndlyName=D.FriendlyName,
				IP.SetAlert=@InSetAlert, 
				IP.UpDcdTime=GETDATE()  
			OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.GrpID,DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.FrndlyName,
				   DELETED.SetAlert,DELETED.DcdTime,DELETED.UpDcdTime,GETDATE()
			INTO PubIPMon_Config_History(MemberID,SiteID,GrpID,PubIPRegID,PubIPAddrs,FrndlyName,SetAlert,DcdTime,UpDcdTime,InsertedOn)			   
			FROM PubIPMon_Config IP		
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData
			INNER JOIN #IPDetails D ON D.RegId=IP.PubIPRegID 	
			
			UPDATE R
			SET R.ResFriendlyName=D.FriendlyName 
			FROM RegMain R
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=R.RegId 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			INNER JOIN #IPDetails D WITH(NOLOCK) ON D.RegId=IP.PubIPRegID 
			
			UPDATE G
			SET G.ResFriendlyName=D.FriendlyName 
			FROM GlobalConfig G
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=G.RegId 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			INNER JOIN #IPDetails D WITH(NOLOCK) ON D.RegId=IP.PubIPRegID 
			
			----While updation if any new ip added then Insert New records and if already present then exclude----
			
			INSERT INTO PubIPMon_Config(MemberID,SiteID,GrpID,PubIPRegID,PubIPAddrs,FrndlyName,SetAlert) 
			SELECT @InMemberID,@InSiteID,S.strData,A.RegId,A.IPAddress,A.FriendlyName,@InSetAlert  
			FROM #IPDetails A
			INNER JOIN dbo.SplitText(@InGrpID,',') AS S ON A.GrpID=S.strData 
			LEFT JOIN PubIPMon_Config PC WITH(NOLOCK) ON PC.PubIPRegID=A.RegId 
			WHERE PC.PubIPRegID IS NULL
			
			INSERT INTO PubIPMon_Lookup(GrpID,PubIPRegID,PubIPAddrs,ActionTkn,DcdTime) 
			SELECT S.strData,A.RegId,A.IPAddress,'Add',GETDATE()
			FROM #IPDetails A 
			INNER JOIN dbo.SplitText(@InGrpID,',') AS S ON S.strData=A.GrpID  
			LEFT JOIN PubIPMon_Lookup PL WITH(NOLOCK) ON PL.PubIPRegID=A.RegId AND PL.ActionTkn='Add'
			WHERE PL.PubIPRegID IS NULL
			
			------While updation if any IP removed then delete and mark disable in all respective tables------
			UPDATE R
			SET RegStatus='UNINSTALL',
				UnInstDate=GETDATE()
			FROM RegRSMAliveStatus R 
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=R.RegId 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			LEFT JOIN #IPDetails I ON I.RegId=IP.PubIPRegID 
			WHERE I.RegId IS NULL
			
			UPDATE P 
			SET ActionTkn='Remove',
				UpDcdTime=GETDATE(),
				IsProcessed=0
			FROM PubIPMon_Lookup P
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=P.PubIPRegID 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			LEFT JOIN #IPDetails I ON I.RegId=IP.PubIPRegID 
			WHERE I.RegId IS NULL
			
		-------------------------Newly Added code to remove entry from PubIPMon_ConfigStatus	
			DELETE IPS  		   
			OUTPUT DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.IPStatus,DELETED.ErrCode,DELETED.ErrDesc,DELETED.TracertDesc,
			   DELETED.DcdTime,DELETED.UpDcdTime,GETDATE() 	  
			INTO PubIPMon_ConfigStatus_History(PubIPRegID,PubIPAddrs,IPStatus,ErrCode,ErrDesc,TracertDesc,DcdTime,UpDcdTime,InsertedOn) 
			FROM PubIPMon_ConfigStatus IPS	
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IPS.PubIPRegID=IP.PubIPRegID 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			LEFT JOIN #IPDetails I ON I.RegId=IP.PubIPRegID 
			WHERE I.RegId IS NULL
		--------------------------------------------------------------------------------				
			DELETE IP  
			OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.GrpID,DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.FrndlyName,
				   DELETED.SetAlert,DELETED.DcdTime,DELETED.UpDcdTime,GETDATE()
			INTO PubIPMon_Config_History(MemberID,SiteID,GrpID,PubIPRegID,PubIPAddrs,FrndlyName,SetAlert,DcdTime,UpDcdTime,InsertedOn)			   
			FROM PubIPMon_Config IP	
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			LEFT JOIN #IPDetails I ON I.RegId=IP.PubIPRegID 
			WHERE I.RegId IS NULL
			
		END
	ELSE IF @InMode='D'
		BEGIN
			UPDATE R
			SET RegStatus='UNINSTALL',
				UnInstDate=GETDATE()
			FROM RegRSMAliveStatus R 
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IP.PubIPRegID=R.RegId 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
		
		--------------------------------------------------------------------------
			UPDATE P 
			SET ActionTkn='Remove',
				UpDcdTime=GETDATE(),
				IsProcessed=0
			FROM PubIPMon_Lookup P
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON P.GrpID=S.strData  
			
		-------------------------Newly Added code to remove entry from PubIPMon_ConfigStatus	
			DELETE IPS  		   
			OUTPUT DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.IPStatus,DELETED.ErrCode,DELETED.ErrDesc,DELETED.TracertDesc,
			   DELETED.DcdTime,DELETED.UpDcdTime,GETDATE() 	  
			INTO PubIPMon_ConfigStatus_History(PubIPRegID,PubIPAddrs,IPStatus,ErrCode,ErrDesc,TracertDesc,DcdTime,UpDcdTime,InsertedOn) 
			FROM PubIPMon_ConfigStatus IPS	
			INNER JOIN PubIPMon_Config IP WITH(NOLOCK) ON IPS.PubIPRegID=IP.PubIPRegID 
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  
			LEFT JOIN #IPDetails I ON I.RegId=IP.PubIPRegID 
			WHERE I.RegId IS NULL			
		--------------------------------------------------------------------------		
		
			DELETE IP  
			OUTPUT DELETED.MemberID,DELETED.SiteID,DELETED.GrpID,DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.FrndlyName,
				   DELETED.SetAlert,DELETED.DcdTime,DELETED.UpDcdTime,GETDATE()
			INTO PubIPMon_Config_History(MemberID,SiteID,GrpID,PubIPRegID,PubIPAddrs,FrndlyName,SetAlert,DcdTime,UpDcdTime,InsertedOn)			   
			FROM PubIPMon_Config IP
			INNER JOIN DBO.SplitText(@InGrpID,',') S ON IP.GrpID=S.strData  		
		END 
		--------------------------------------------------------------------------	
		IF OBJECT_ID('tempdb..#IPDetails') IS NOT NULL
		BEGIN
			DROP TABLE #IPDetails
		END
		
	SET @OutStatus=1
END TRY

BEGIN CATCH
	SET @OutStatus=0
END CATCH	
SET NOCOUNT OFF
GO
