SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/*===================================================================================         
SP Name          : Find      
Updatedby    : Abhishek        
Created Date     : 12 December 2007        
Created By       : Abhishek      
Created Date     : 06 September 2007        
===================================================================================*/      
CREATE Proc FIND       
 @strsearch varchar(100)        
AS        
 set @strsearch='%'+@strsearch+'%'        
 print @strsearch        
Select distinct a.id,a.name,(case a.xtype when 'P' then 'SP' when 'V' then 'VIEW' end) TYPE from sysobjects  a with (NOLOCK) inner join         
 syscomments b with (NOLOCK) on a.id=b.id        
  where a.xtype in ('P','V')        
  and (b.text like @strsearch) order by a.name  
  
GO
