SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_ResponseTime]
	@OUTServerName varchar(25) OUTPUT

AS


----------------------------------------------------- 
/*
declare @OUTServerName varchar(25)
EXEC [USP_ResponseTime] @OUTServerName OUTPUT
print @OUTServerName

=======================PURPOSE=======================
get reponse of sp
===================INPUT / OUTPUT ===================
INPUT PARA
	NONE
OUTPUT PARA
	@OUTServerName
==================PAGE NAME (CALLING)================

==================CREATED BY / DATE==================
DEEPESH JOSHI
26/5/2008
==================CHANGED BY / DATE==================
*/
-----------------------------------------------------


SET NOCOUNT ON

	SELECT  @OUTServerName='server_zil'


SET NOCOUNT OFF
GO
