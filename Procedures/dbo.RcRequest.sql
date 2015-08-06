SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



/*

declare @T Varchar(50)
exec RcRequest 1,666,@t output

print @t



-- =============================================
-- Description:	Using In  30SecRc Database
-- For As Per Remote user Request Sending Code to Server and Updating RcDtime Field When its Given To Server
-- 
-- =============================================

*/

CREATE  PROCEDURE [dbo].[RcRequest]      
 @InRegID Bigint,
 @InRCCode Varchar(20),	
 @OutStatus Varchar(50) OutPut 
AS      

SET NOCOUNT ON      

DECLARE @RegID bigint
DECLARE @RcSecond Int
DECLARE @RcCode Varchar(20)
DECLARE @ERR INT

		Set @RegID=0
		Set @RcSecond=''
		
		Select 	@RegID=Regid ,@RcSecond=Datediff(ss,dctime,getdate()),@RcCode=RcKey from RcDTime WITH(NOLOCK) where Regid=@InRegID
		
		SET @ERR=@@ERROR
		
		IF @ERR=0
			BEGIN
	
				IF @RegID<>0
					IF @RcCode<>0
						BEGIN
							Set @OutStatus ='TRUE_QUEUE'
						END
					ELSE
							BEGIN
								Set @OutStatus ='TRUE_'+ convert(varchar(10),@RcSecond)		
										
								UPDATE RCDTime WITH(ROWLOCK) SET RCKey = @InRCCode,RcDtime=getdate() WHERE RegId =@InRegID 
								
							END
					
					
				IF @RegID=0
					SET @OutStatus='FALSE_REGID NOT FOUND'
			END
		IF @ERR<>0
			BEGIN
				Set @OutStatus ='FALSE_ERROR OCCURED WHILE REQUEST'	
			END
	

SET NOCOUNT OFF
GO
