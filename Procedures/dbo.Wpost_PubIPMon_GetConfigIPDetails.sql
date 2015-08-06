SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Wpost_PubIPMon_GetConfigIPDetails]
@InType VARCHAR(50)
AS
/*
===================EXEC================
EXEC [Wpost_PubIPMon_GetConfigIPDetails] 'Full'  
GO
EXEC [Wpost_PubIPMon_GetConfigIPDetails] 'Partial' 
=====================PURPOSE========================= 
To get the list for all servers along with linux agents against Siteid and MemberID.
PubIPMon_SupRegIDMapping
=====================OUTPUT========================== 

=====================PAGE NAME(CALLING)==============
Called by Wpost
=====================CREATED BY/DATE ================
Anamika Pandey
1st July 2014
=====================CHANGED BY/DATE ================
Anamika Pandey
25th July 2014
Changed @intype value as Partial.
=====================CHANGED BY/DATE ================
Anamika Pandey
7th August 2014
Removed check for IsProcessed=0 in case of @InType='Full'.
=====================CHANGED BY/DATE ================
Anamika Pandey
13th August 2014
Handled Case for column ActionTkn
*/ 
--------------------------------------------------------------------

SET NOCOUNT ON

	IF @InType='Full'
		BEGIN
			SELECT P.PubIPRegID,P.PubIPAddrs,
				  CASE WHEN PL.ActionTkn='Add' THEN 'A' 
					   WHEN PL.ActionTkn='Remove' THEN 'R' 
				  END AS ActionTkn	       
			FROM PubIPMon_Config P WITH(NOLOCK)
			INNER JOIN PubIPMon_Lookup PL WITH(NOLOCK) ON PL.PubIPRegID=P.PubIPRegID 
			INNER JOIN MstPubIPMon_Group PG WITH(NOLOCK) ON PG.GrpID=P.GrpID
			INNER JOIN RegRSMAliveStatus RS WITH(NOLOCK) ON RS.RegId=P.PubIPRegID AND RS.RegStatus='ENABLED' 
			WHERE PL.ActionTkn='Add' AND PG.IsEnabled=1  
		END
	ELSE IF @InType='Partial'
		BEGIN
			SELECT PL.PubIPRegID,PL.PubIPAddrs,
				   CASE WHEN PL.ActionTkn='Add' THEN 'A' 
					    WHEN PL.ActionTkn='Remove' THEN 'R' 
				  END AS ActionTkn	
			FROM PubIPMon_Lookup PL WITH(NOLOCK)
			WHERE PL.IsProcessed=0
			ORDER BY PL.ActionTkn 
		END

SET NOCOUNT OFF
GO
