/******************************************************************************\ 
* Name: SQLleftjoin.sas
* 
* Purpose: Create an inner join using PROC SQL from work.lefttable and 
*          work.righttable.  These results serve as comparison to the results 
*          from innerhash.sas.  The only difference will be order.
* 
* Author: Jesse Behrens
* 
* Input: work.lefttable & work.righttable from generatedata.sas
* Output: work.OutputInnerSQL
*
* History: 
* 03/02/2017 Initial creation of code
\******************************************************************************/

PROC SQL noprint;
  create table OutputInnerSQL as
  select a.KeyL, a.VarA, a.VarB, a.VarC, a.VarD,a.VarE,b.KeyR,
         b.VarJ,b.VarN,b.VarP, b.VarR
  from lefttable a inner join righttable b on a.KeyL=b.KeyR;
QUIT;
