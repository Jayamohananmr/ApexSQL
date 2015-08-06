SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
GO
/*         
==========================ALTER BY/DATE =========================  
Anamika Pandey
14th Aug 2014 
Taken script from ITUpport247DB and altered in 30SecRc.
*/   
--------------------------------------------------------------------  

CREATE  FUNCTION [dbo].[SplitText]
                    (@list      ntext,
                     @delimiter nchar(1) = N',')
         RETURNS @tbl TABLE (--listpos int IDENTITY(1, 1) NOT NULL,
                             --nstr    nvarchar(2000) ,
 									  strData varchar(4000)) AS

   BEGIN
      DECLARE @pos      int,
              @textpos  int,
              @chunklen smallint,
              @tmpstr   nvarchar(4000),
              @leftover nvarchar(4000),
              @tmpval   nvarchar(4000)

      SET @textpos = 1
      SET @leftover = ''
      WHILE @textpos <= datalength(@list) / 2
      BEGIN
         SET @chunklen = 4000 - datalength(@leftover) / 2
         SET @tmpstr = @leftover + substring(@list, @textpos, @chunklen)
         SET @textpos = @textpos + @chunklen

         SET @pos = charindex(@delimiter, @tmpstr)

         WHILE @pos > 0
         BEGIN
            SET @tmpval = ltrim(rtrim(left(@tmpstr, @pos - 1)))
            --INSERT @tbl (str, nstr) VALUES(@tmpval, @tmpval)
				INSERT @tbl (strData) VALUES( @tmpval)	
            SET @tmpstr = substring(@tmpstr, @pos + 1, len(@tmpstr))
            SET @pos = charindex(@delimiter, @tmpstr)
         END

         SET @leftover = @tmpstr
      END

      --INSERT @tbl(str, nstr) VALUES (ltrim(rtrim(@leftover)), ltrim(rtrim(@leftover)))
		INSERT @tbl(strData) VALUES (ltrim(rtrim(@leftover)))	
   RETURN
   END
GO
