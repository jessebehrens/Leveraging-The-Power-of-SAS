/******************************************************************************\ 
* Name: SQLleftjoin.sas
* 
* Purpose: Create a left join using PROC SQL from work.lefttable and 
*          work.righttable.  These results server as comparison to the results 
*          from lefthash.sas.  The only difference will be order.
* 
* Author: Jesse Behrens
* 
* Input: work.lefttable & work.righttable from generatedata.sas
*
* History: 
* 02/28/2017 Initial creation of code
\******************************************************************************/

PROC SQL noprint;
  create table OutputTableSQL as
  select lt.KeyL, lt.VarA, lt.VarB, lt.VarC, lt.VarD,lt.VarE,
         rt.KeyR, rt.VarJ,rt.VarN,rt.VarP, rt.VarR
  from lefttable as lt left join righttable as rt on lt.KeyL=rt.KeyR;
QUIT;
