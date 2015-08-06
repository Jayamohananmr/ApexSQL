SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*    
declare @T Varchar(50)  
exec [RcStatus]  1,@t output    
print @t    
-- =============================================  
-- Description: Using In  30SecRc Database  
-- For Remote User Checking IS Request ID available Or not  
-- If Not Found Regid On the Table then Inserting data to the Table  
-- If The Time Different is >2 mintes then its empty the RcKey  and Returning Success  
-- If Data is there then Returning RCKey and Empty RcKey  
-- =============================================  
  
*/  
  
  
CREATE    PROCEDURE [dbo].[RcStatus]          
 @InRegID Bigint,    
 @OutStatus Varchar(50) OutPut     
AS          

SET NOCOUNT ON   
       
DECLARE @RegID bigint    
DECLARE @RcKey varchar(20)  
DECLARE @ERR INT  
DECLARE @RCDtime varchar(25)  
DECLARE @DCtime datetime  
    
--RcDtime  
   
  Set @RegID=0    
  Set @RcKey=''    
   
  Select  @RegID=Regid ,@RcKey=RcKey ,@RCDtime=RcDtime,@DCtime=DcTime from RcDTime WITH(NOLOCK) where Regid=@InRegID    
  SET @ERR=@@ERROR  
    
  IF @ERR=0  
 	IF @REGID=0 and @InRegID<>0
		BEGIN

			INSERT INTO RCDTime (RegId) Values (@InRegID) 
		END
   
   IF DATEDIFF(mi,@DCtime,convert(datetime,@RCDtime))>2   or @RCDtime is null  
		  BEGIN  
		   UPDATE RCDTime WITH(ROWLOCK)  SET route=0, RCKey = '',RcDtime=Null,DcTime=Getdate() 
				WHERE RegId =@InRegID     
		   
				Set @OutStatus ='TRUE_'  
				GOTO SUCCESS  
		  END  
    
       
   BEGIN    
		IF @RegID<>0  
			BEGIN  
			   IF @RcKey<>0  
					BEGIN  
						Set @OutStatus ='TRUE_'+ @RcKey  
					END  
			   ELSE  
					BEGIN  
						Set @OutStatus ='TRUE_'  
					END  
		      
				UPDATE RCDTime WITH(ROWLOCK) SET  route=0, RCKey = '',DcTime=Getdate(),RcDtime=Null 
					WHERE RegId =@InRegID     
			END  
			
		IF @RegID=0  
	
		   BEGIN  
		      
				INSERT INTO RCDTime (RegId) Values (@InRegID)  
		      
				SET @ERR=@@ERROR  
		      
				 IF @ERR=0  
						SET @OutStatus='TRUE_'  
				 IF @ERR<>0  
						SET @OutStatus='FALSE_'  
		   END    
   END    
	  
	  IF @ERR<>0    
	   BEGIN    
		Set @OutStatus ='FALSE_ERROR OCCURED WHILE UPDATING'     
	   END    
  
   GOTO SUCCESS  
  
SUCCESS:
 
  
SET NOCOUNT OFF
GO
