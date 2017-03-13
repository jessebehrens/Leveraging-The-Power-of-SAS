/******************************************************************************\ 
* Name: SQLfulljoin.sas
* 
* Purpose: Create a full join using PROC SQL from work.lefttable and 
*          work.righttable.  These results serve as comparison to the results 
*          from fulljoinhash.sas.  The only difference will be order.
* 
* Author: Jesse Behrens
* 
* Input: work.lefttable & work.righttable from generatedata.sas
* Output: work.OutputFullSQL
* History: 
* 03/13/2017 Initial creation of code
\******************************************************************************/

PROC SQL noprint;
  create table OutputFullSQL as
  select lt.KeyL, lt.VarA, lt.VarB, lt.VarC, lt.VarD,lt.VarE,
         rt.KeyR, rt.VarJ,rt.VarN,rt.VarP, rt.VarR
  from lefttable as lt full join righttable as rt on lt.KeyL=rt.KeyR;
QUIT;
