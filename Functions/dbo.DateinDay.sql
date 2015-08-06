SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 

CREATE FUNCTION [dbo].[DateinDay](@MaxDt datetime,@MinDt datetime)

	returns Varchar(500)

BEGIN
	DECLARE @S BIGINT
	DECLARE @D INT
	DECLARE @H INT
	DECLARE @M INT
	DECLARE @STRV VARCHAR(200)

	Set @STRV=''
	SET @S=abs(DATEDIFF(s,@MinDt,@MaxDt))
	SET @D=@S/86400
	SET @S=@S-(86400*@D)	

	SET @H=@S/3600
	SET @S=@S-(3600*@H)	

	SET @M=@S/60
	SET @S=@S-(60*@M)	

	SET @Strv= cast(@D as varchar)+ ' Days '+	cast(@H as varchar) +' Hrs ' + cast(@M as varchar) +' Minutes ' + cast(@S as varchar) + ' Sec ' 
	RETURN @STRV		
	
END 
GO
