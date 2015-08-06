SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_DDConfig_Thld_IUD]
(
	@InRegID		VARCHAR(Max) = NULL,
	@InSiteID		VARCHAR(max) = NULL,
	@InMemberID		BIGINT = NULL,
	@InDDRCThld		BIGINT = NULL,
	@InDDKAThld		BIGINT = NULL,
	@InGroupType	CHAR(1) = NULL,
	@InCreatedBy	VARCHAR(300),
	@InMode			VARCHAR(50),
	@OutStatus		INT	OUTPUT
)
AS
/*
DECLARE @OutStatus INT
EXEC [USP_DDConfig_Thld_IUD] @InRegID='2,4,34',@InSiteID=NULL,@InMemberID=NULL,@InDDRCThld=10,@InDDKAThld=10,
		@InGroupType='R',@InCreatedBy='Paresh',@InMode='NEW',@OutStatus=@OutStatus OUTPUT
SELECT @OutStatus
GO
DECLARE @OutStatus INT
EXEC [USP_DDConfig_Thld_IUD] @InRegID=NULL,@InSiteID='199',@InMemberID=NULL,@InDDRCThld=12,@InDDKAThld=12,
		@InGroupType='S',@InCreatedBy='Paresh',@InMode='NEW',@OutStatus=@OutStatus OUTPUT
SELECT @OutStatus
GO
DECLARE @OutStatus INT
EXEC [USP_DDConfig_Thld_IUD] @InRegID=NULL,@InSiteID=NULL,@InMemberID=1,@InDDRCThld=13,@InDDKAThld=13,
		@InGroupType='M',@InCreatedBy='Paresh',@InMode='NEW',@OutStatus=@OutStatus OUTPUT
SELECT @OutStatus
*/
SET NoCount ON
BEGIN TRY
	DECLARE @Details TABLE
	(
		ID bigint identity(1,1),
		MemberID	Bigint,
		SiteID		Bigint,
		RegId		Bigint
	)

	IF @InGroupType = 'R'
	Begin
		INSERT INTO @Details(MemberID,SiteID,RegId)
		SELECT RM.MemberID,RM.SiteId,A.strData
		FROM dbo.SplitText(@InRegID,',') A
		INNER JOIN RegMain RM WITH (NOLOCK) ON A.strData = RM.RegId
	End
	IF @InGroupType = 'S'
	Begin
		INSERT INTO @Details(MemberID,SiteID)
		SELECT MS.MemberID,A.strData
		FROM dbo.SplitText(@InSiteID,',') A
		INNER JOIN MstSite MS WITH (NOLOCK) ON A.strData = MS.SiteId
	End
	
	IF @InMode IN ('NEW','UPDATE')
	Begin
	
		IF @InGroupType = 'R'
		Begin
			UPDATE DDR
			SET DDRCThld = @InDDRCThld,
				DDKAThld = @InDDKAThld,
				ModifiedBy = @InCreatedBy,
				ModifiedOn = GETDATE()
			OUTPUT DELETED.TemplateID,DELETED.MemberID,DELETED.SiteID,DELETED.RegID,
				DELETED.DDRCThld,DELETED.DDKAThld,DELETED.GroupType,DELETED.CreatedBy,DELETED.DcdTime,
				DELETED.ModifiedBy,DELETED.ModifiedOn,GETDATE()
			INTO Mst_DDConfig_History(TemplateID,MemberID,SiteID,RegID,
				DDRCThld,DDKAThld,GroupType,CreatedBy,DcdTime,
				ModifiedBy,ModifiedOn,InsertedOn)
			FROM @Details B
			INNER JOIN Mst_DDConfig_Regid DDR ON B.RegID = DDR.RegId
						
			INSERT INTO Mst_DDConfig_Regid(MemberID,SiteID,RegID,DDRCThld,DDKAThld,
					GroupType,CreatedBy,DcdTime)
			SELECT B.MemberID,B.SiteID,B.RegId,@InDDRCThld,@InDDKAThld,
				@InGroupType,@InCreatedBy,GETDATE()
			FROM @Details B
			LEFT JOIN Mst_DDConfig_Regid DDR ON B.RegID = DDR.RegId
			WHERE DDR.RegId IS NULL
			ORDER BY ID
		End
		
		IF @InGroupType = 'S'
		Begin
		
			UPDATE DDS
			SET DDRCThld = @InDDRCThld,
				DDKAThld = @InDDKAThld,
				ModifiedBy = @InCreatedBy,
				ModifiedOn = GETDATE()
			OUTPUT DELETED.TemplateID,DELETED.MemberID,DELETED.SiteID,NULL,
				DELETED.DDRCThld,DELETED.DDKAThld,DELETED.GroupType,DELETED.CreatedBy,DELETED.DcdTime,
				DELETED.ModifiedBy,DELETED.ModifiedOn,GETDATE()
			INTO Mst_DDConfig_History(TemplateID,MemberID,SiteID,RegID,
				DDRCThld,DDKAThld,GroupType,CreatedBy,DcdTime,
				ModifiedBy,ModifiedOn,InsertedOn)
			FROM @Details B
			INNER JOIN Mst_DDConfig_Site DDS ON B.MemberID = DDS.MemberID AND  B.SiteID = DDS.SiteID 
			
			INSERT INTO Mst_DDConfig_Site(MemberID,SiteID,DDRCThld,DDKAThld,
				GroupType,CreatedBy,DcdTime)
			SELECT B.MemberID,B.SiteID,@InDDRCThld,@InDDKAThld,
				@InGroupType,@InCreatedBy,GETDATE()
			FROM @Details B
			LEFT JOIN Mst_DDConfig_Site DDS ON DDS.MemberID = B.MemberID AND  DDS.SiteID = B.SiteID 
			WHERE DDS.SiteID IS NULL
			ORDER BY ID
		End
		
		IF @InGroupType = 'M'
		Begin
			
			UPDATE DDM
			SET DDRCThld = @InDDRCThld,
				DDKAThld = @InDDKAThld,
				ModifiedBy = @InCreatedBy,
				ModifiedOn = GETDATE()
			OUTPUT DELETED.TemplateID,DELETED.MemberID,NULL,NULL,
				DELETED.DDRCThld,DELETED.DDKAThld,DELETED.GroupType,DELETED.CreatedBy,DELETED.DcdTime,
				DELETED.ModifiedBy,DELETED.ModifiedOn,GETDATE()
			INTO Mst_DDConfig_History(TemplateID,MemberID,SiteID,RegID,
				DDRCThld,DDKAThld,GroupType,CreatedBy,DcdTime,
				ModifiedBy,ModifiedOn,InsertedOn)
			FROM Mst_DDConfig_Member DDM
			WHERE MemberID = @InMemberID
			
			IF @@ROWCOUNT = 0
			Begin
			INSERT INTO Mst_DDConfig_Member(MemberID,DDRCThld,DDKAThld,
				GroupType,CreatedBy,DcdTime)
			SELECT @InMemberID,@InDDRCThld,@InDDKAThld,
				@InGroupType,@InCreatedBy,GETDATE()
			End
			
		End
	End

	IF @InMode IN ('DELETE')
	Begin
		IF @InGroupType = 'R'
		Begin
			DELETE DDR
			OUTPUT DELETED.TemplateID,DELETED.MemberID,DELETED.SiteID,DELETED.RegID,
				DELETED.DDRCThld,DELETED.DDKAThld,DELETED.GroupType,DELETED.CreatedBy,DELETED.DcdTime,
				DELETED.ModifiedBy,DELETED.ModifiedOn,GETDATE()
			INTO Mst_DDConfig_History(TemplateID,MemberID,SiteID,RegID,
				DDRCThld,DDKAThld,GroupType,CreatedBy,DcdTime,
				ModifiedBy,ModifiedOn,InsertedOn)
			FROM @Details B
			INNER JOIN Mst_DDConfig_Regid DDR ON B.RegID = DDR.RegId
		End
		
		IF @InGroupType = 'S'
		Begin
			DELETE DDS
			OUTPUT DELETED.TemplateID,DELETED.MemberID,DELETED.SiteID,NULL,
				DELETED.DDRCThld,DELETED.DDKAThld,DELETED.GroupType,DELETED.CreatedBy,DELETED.DcdTime,
				DELETED.ModifiedBy,DELETED.ModifiedOn,GETDATE()
			INTO Mst_DDConfig_History(TemplateID,MemberID,SiteID,RegID,
				DDRCThld,DDKAThld,GroupType,CreatedBy,DcdTime,
				ModifiedBy,ModifiedOn,InsertedOn)
			FROM @Details B
			INNER JOIN Mst_DDConfig_Site DDS ON B.MemberID = DDS.MemberID AND  B.SiteID = DDS.SiteID 
		End
		
		IF @InGroupType = 'M'
		Begin
			DELETE DDM
			OUTPUT DELETED.TemplateID,DELETED.MemberID,NULL,NULL,
				DELETED.DDRCThld,DELETED.DDKAThld,DELETED.GroupType,DELETED.CreatedBy,DELETED.DcdTime,
				DELETED.ModifiedBy,DELETED.ModifiedOn,GETDATE()
			INTO Mst_DDConfig_History(TemplateID,MemberID,SiteID,RegID,
				DDRCThld,DDKAThld,GroupType,CreatedBy,DcdTime,
				ModifiedBy,ModifiedOn,InsertedOn)
			FROM Mst_DDConfig_Member DDM
			WHERE MemberID = @InMemberID
		End
		
	End
	
	SET @OutStatus = 1
	
	SET @OutStatus = 1
END TRY
BEGIN CATCH
	SET @OutStatus = 0
END CATCH
SET NoCount OFF


GO
