SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_NET_PubIPMon_Registration]
@InXml VARCHAR(MAX),
@OutStatus INT OUTPUT
AS

/*
=====================================================================
DECLARE @OutStatus INT
DECLARE @XML VARCHAR(MAX)
SET @XML='<NewDataSet>
		  <Table1>
			  <MemberCode>Zenith Infotech DemoCenter</MemberCode>
			  <MemberID>1</MemberID>
			  <SiteId>1</SiteId>
			  <SiteCode>Russel Lurie</SiteCode>
			  <SiteSubCode>Russel Test</SiteSubCode>
			  <GUID>832557AF-4632-4E2B-A5B7-E1F5EC76F2F6</GUID>
			  <ResourceName>1.2.2.1</ResourceName>
			  <ResType>11</ResType>
			  <RegId>2414661</RegId>
			  <RegType>MSMA</RegType>
			  <FriendlyName>Fname1</FriendlyName>
		  </Table1>
		  <Table1>
			<MemberCode>Zenith Infotech DemoCenter</MemberCode>
			<MemberID>1</MemberID>
			<SiteId>1</SiteId>
			<SiteCode>Russel Lurie</SiteCode>
			<SiteSubCode>Russel Lurie</SiteSubCode>
			<GUID>E107984D-1003-4306-BB64-F182ACA7FC55</GUID>
			<ResourceName>1.2.2.2</ResourceName>
			<ResType>11</ResType>
			<RegId>2414662</RegId>
			<RegType>MSMA</RegType>
			<FriendlyName>Fname2</FriendlyName>
		  </Table1>
		</NewDataSet>'
EXEC [USP_NET_PubIPMon_Registration] @XML ,@OutStatus OUTPUT
SELECT @OutStatus
======================================PURPOSE=======================             
Sp used for Public IP Monitoring Registration Process.
===========================================================
INPUT Parameter
	@InXml VARCHAR(MAX)
OUTPUT Parameter
	@OUTVALUE INT OUTPUT
====================PAGE NAME=====================
PubIpMon.aspx
=====================CREATED BY/DATE ================  
Anamika Pandey
10th July 2014
*/

SET NOCOUNT ON

DECLARE @XML XML 
SET @XML=CAST(@InXML AS XML)

	IF OBJECT_ID('tempdb..#RegIDDtls') IS NOT NULL
	BEGIN
		DROP TABLE #RegIDDtls
	END

	CREATE TABLE #RegIDDtls
	(   
		MemberCode VARCHAR(30),
		MemberID BIGINT,
		SiteId BIGINT,
		SiteCode VARCHAR(30),
		SiteSubCode VARCHAR(30),
		[GUID] VARCHAR(57),
		ResourceName VARCHAR(100),
		ResType INT,
		RegID BIGINT,
		RegType VARCHAR(10),
		ResFriendlyName VARCHAR(100)
	)	

	BEGIN TRY	
	
	INSERT INTO #RegIDDtls(MemberCode,MemberID,SiteId,SiteCode,SiteSubCode,[GUID],ResourceName,ResType,RegID,RegType,ResFriendlyName)  

	SELECT  fields.value('MemberCode[1]','varchar(30)') AS MemberCode,
			fields.value('MemberID[1]','bigint') AS MemberID, 
			fields.value('SiteId[1]','bigint') AS SiteId,
			fields.value('SiteCode[1]','varchar(30)') AS SiteCode,
			fields.value('SiteSubCode[1]','varchar(30)') AS SiteSubCode,
			fields.value('GUID[1]','varchar(57)') AS [GUID],
			fields.value('ResourceName[1]','varchar(100)') AS ResourceName, 
			fields.value('ResType[1]','int') ResType,
			fields.value('RegId[1]','bigint') AS RegID,
			fields.value('RegType[1]','varchar(10)') RegType,
			fields.value('FriendlyName[1]','varchar(100)') AS ResFriendlyName
    FROM @XML.nodes('/NewDataSet/Table1') AS xmldata(fields)

	
		INSERT INTO REGMAIN(MemberCode,MemberID,SiteId,SiteCode,SiteSubCode,[GUID],ResourceName,ResType,RegID,RegType,ResFriendlyName) 
		
		SELECT IP.MemberCode,IP.MemberID,IP.SiteId,IP.SiteCode,IP.SiteSubCode,IP.[GUID],IP.ResourceName,IP.ResType,
			   IP.RegID,IP.RegType,IP.ResFriendlyName
		FROM #RegIDDtls	IP WITH(NOLOCK)
		LEFT JOIN RegMain RM WITH(NOLOCK) ON RM.RegId=IP.RegID 
		WHERE RM.RegId IS NULL			
	--------------------------------------------------------------------------	
				
		INSERT INTO RegRSMAliveStatus(RegId,DCTime,RegStatus) 
		
		SELECT R.RegId,GETDATE(),'ENABLED'
		FROM RegMain R WITH(NOLOCK)
		INNER JOIN #RegIDDtls IP WITH(NOLOCK) ON IP.MemberID=R.MemberID AND IP.SiteId=R.SiteId AND IP.GUID=R.GUID
		LEFT JOIN RegRSMAliveStatus RS WITH(NOLOCK) ON RS.RegId=R.RegId 
		WHERE RS.RegId IS NULL
	--------------------------------------------------------------------------	
	
		INSERT INTO GlobalConfig(MemberCode,MemberId,SiteId,SiteCode,SiteSubCode,[GUID],ResourceName,ResType,RegType,
								 ResFriendlyName,Regid,ResMSRemoteLocal,Pingpackets,Pingtimeout,PingCycleCnt,
								 PerformancecycleCnt,Porttimeout,ResFromTime, ResToTime, ResDays) 
		SELECT IP.MemberCode,IP.MemberId,IP.SiteId,IP.SiteCode,IP.SiteSubCode,IP.[GUID],IP.ResourceName,IP.ResType,
			   IP.RegType,IP.ResFriendlyName,IP.Regid,'Local',NULL,NULL,NULL,NULL,NULL,'00:00','00:00',''  
		FROM #RegIDDtls IP		
		INNER JOIN RegMain R WITH(NOLOCK) ON IP.MemberID=R.MemberID AND IP.SiteId=R.SiteId AND IP.GUID=R.GUID					
		LEFT JOIN GlobalConfig G WITH(NOLOCK) ON G.RegId=R.RegId 
		WHERE G.RegId IS NULL
		 
		SET @OutStatus =1
	END TRY
	
	BEGIN CATCH
		SET @OutStatus =0
	END CATCH
	
SET NOCOUNT OFF
GO
