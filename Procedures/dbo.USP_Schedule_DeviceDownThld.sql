SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[USP_Schedule_DeviceDownThld] 
AS
-------------------------------------------------------------
/*

EXEC [USP_Schedule_DeviceDownThld] 

=====================PURPOSE========================= 
To Insert Record in Regid table of Suppression sitewise 
================INPUT/OUTPUT PARAM===================
INPUT :- NONE
OUTPUT :- NONE
		
================PAGE NAME(CALLING)===================

=================CREATED BY/DATE=====================
Paresh Bhadekar
3rd Jan 2013


*/
-------------------------------------------------------------

SET NOCOUNT ON

DECLARE @CurrentDate DATETIME
SET @CurrentDate = GETDATE() 

BEGIN TRY

	--BEGIN TRANSACTION

		DECLARE @Mst_DDConfig TABLE 
		(
			TemplateID		Bigint,
			MemberID	Bigint,
			SiteID		Bigint,
			DDRCThld	Bigint,
			DDKAThld	Bigint,
			GroupType	Char(1),
			IsProcessed	Bit default 0,
			CreatedBy	Varchar(300),
			DcdTime		DATETIME DEFAULT getdate(),
			ModifiedBy	Varchar(300),
			ModifiedOn	DATETIME		
		) 


		INSERT INTO @Mst_DDConfig (TemplateID,MemberID,SiteID,DDRCThld,DDKAThld,GroupType,
				IsProcessed,CreatedBy,DcdTime,ModifiedBy,ModifiedOn)
		SELECT DD.TemplateID,DD.MemberID,DD.SiteID,DD.DDRCThld,DD.DDKAThld,DD.GroupType,
				DD.IsProcessed,DD.CreatedBy,DD.DcdTime,DD.ModifiedBy,DD.ModifiedOn
		FROM Mst_DDConfig DD WITH(NOLOCK)
		WHERE IsProcessed = 0
		
		--select * from @Mst_DDConfig
		
		UPDATE Mst_DDConfig_Regid
		SET DDRCThld = DD.DDRCThld,
			DDKAThld = DD.DDKAThld,
			ModifiedBy = DD.ModifiedBy,
			ModifiedOn = DD.ModifiedOn
		FROM @Mst_DDConfig DD	
			INNER JOIN RegMain RM WITH (NOLOCK) ON RM.MemberID = DD.MemberID AND RM.SiteId = DD.SiteId 
			INNER JOIN Mst_DDConfig_Regid DDR WITH (NOLOCK) ON RM.RegId = DDR.RegID AND DDR.GroupType = DD.GroupType
		WHERE DD.GroupType='S' 
		
		
		INSERT INTO Mst_DDConfig_Regid(MemberID,SiteID,RegID,DDRCThld,DDKAThld,
				GroupType,CreatedBy,GlobDcdTime,ModifiedBy,ModifiedOn)
		SELECT RM.MemberID,RM.SiteID,RM.RegId,DD.DDRCThld,DD.DDKAThld,
				DD.GroupType,DD.CreatedBy,DD.DcdTime,DD.ModifiedBy,DD.ModifiedOn
		FROM @Mst_DDConfig DD	
			INNER JOIN RegMain RM WITH (NOLOCK) ON RM.MemberID = DD.MemberID AND RM.SiteId = DD.SiteId 
			LEFT JOIN Mst_DDConfig_Regid DDR WITH (NOLOCK) ON RM.RegId = DDR.RegID
		WHERE DD.GroupType='S' AND DDR.RegID IS NULL
		
		
		
		UPDATE Mst_DDConfig_Regid
		SET DDRCThld = DD.DDRCThld,
			DDKAThld = DD.DDKAThld,
			ModifiedBy = DD.ModifiedBy,
			ModifiedOn = DD.ModifiedOn
		FROM @Mst_DDConfig DD	
			INNER JOIN RegMain RM WITH (NOLOCK) ON RM.MemberID = DD.MemberID AND RM.SiteId = DD.SiteId 
			INNER JOIN Mst_DDConfig_Regid DDR WITH (NOLOCK) ON RM.RegId = DDR.RegID AND DDR.GroupType = DD.GroupType
		WHERE DD.GroupType='M'
		
		INSERT INTO Mst_DDConfig_Regid(MemberID,SiteID,RegID,DDRCThld,DDKAThld,
				GroupType,CreatedBy,GlobDcdTime,ModifiedBy,ModifiedOn)
		SELECT RM.MemberID,RM.SiteID,RM.RegId,DD.DDRCThld,DD.DDKAThld,
				DD.GroupType,DD.CreatedBy,DD.DcdTime,DD.ModifiedBy,DD.ModifiedOn
		FROM @Mst_DDConfig DD	
			INNER JOIN RegMain RM WITH (NOLOCK) ON RM.MemberID = DD.MemberID
			LEFT JOIN Mst_DDConfig_Regid DDR WITH (NOLOCK) ON RM.RegId = DDR.RegID
		 WHERE DD.GroupType='M' AND DDR.RegID IS NULL
		 
		 
		 
		--UPDATE DD
		--SET IsProcessed = 1,
		--	ProcessCompletedOn = GETDATE()
		--FROM Mst_DDConfig DD
		--INNER JOIN @Mst_DDConfig DDVar On DD.TemplateID = DDVar.TemplateID
		

--		 
--		 UPDATE reg SET REG.PrimaryFilter =EMAIL.[PrimaryFilter]
--		FROM	ViwResourceMSMA_ExcludeackupAgt v WITH(NOLOCK)  
--				INNER JOIN 	@MstAlertSUP email  ON v.memberid = email.memberid 
--									AND v.Siteid = ISNULL(email.SiteID  ,V.SITEID)
--				INNER JOIN 	[MstAlertFamily] alrt WITH(NOLOCK)  ON alrt.ConditionID = email.ConditionID AND  IsSuppressionApplicable = 1  
-- 				INNER JOIN 	MstAlertSUP_Regid reg WITH(NOLOCK)   ON reg.regid = v.regid AND reg.ConditionID = email.ConditionID 
--					AND   reg.GroupType=EMAIL.GROUPTYPE
--		WHERE	IsProcessed = 0 AND Restype = 1 
----			AND
----			  ISNULL(REG.PrimaryFilter,'')<>ISNULL(EMAIL.[PrimaryFilter],'')
----				


		
 


	--COMMIT TRANSACTION

END TRY
BEGIN CATCH

	--ROLLBACK TRANSACTION

END CATCH 

SET NOCOUNT OFF

GO
