/******************************************************************************\ 
* Name: lefthash.sas
* 
* Purpose: Create a left join using a hash object in SAS.  Use SQLleftjoin.sas
*          to compare results.  The only difference will be order.
* 
* Author: Jesse Behrens
* 
* Input: work.lefttable & work.righttable from generatedata.sas
* Output: work.OutputleftHash
*
* History: 
* 02/28/2017 Initial creation of code
* 03/02/2017 Added call missing to the code to remove the warning that the
             newly formed variables were not initialized. 
\******************************************************************************/

/*Output table name*/ 
DATA work.OutputleftHash; 

/*Load the table to be left joined into by the right table
  Keep only the variables needed from the 'left table'
*/
  set work.lefttable (drop=VarF VarG VarH VarI);

/*This populates variables into our program data vector that exist in the
  dataset 'righttable.'  All variables that are being merged in must be 
  declared first.  I personally like to use the length statement, but other 
  methods work
*/


  length KeyR $5. VarJ VarN VarP VarR 8.;

/*Now we will declare the hash object.  We need to define the key to match on, the data
  to be brough in. Since hash objects are put into memory, I only load the variables
  needed for the merge using the keep statement.
  The _N_ makes sure the table is only loaded into memory once 
*/

  IF _N_=1 then do;
    declare hash h(dataset:'righttable(keep=KeyR VarJ VarN VarP VarR)',multidata:'y');
    h.defineKey('KeyR');
    h.defineData('VarJ','VarN','VarP','VarR', 'KeyR');
    h.defineDone();
    call missing(KeyR, VarJ, VarN, VarP, VarR);
  END;

/*Let's look to see if there are any key matches using the find and check functions*/
  IF ^h.check(key:KeyL) then h.find(Key:KeyL);
  output;

/*Hash tables look for only one match even with multidata option set to 'y'.  We will
  need to implement a DO loop to find the rest of the matches.  We will use the has_next()
  function to find additional matches, if they exist.
*/

  h.has_next(result:r);

/*R will be zero if there are no other matches. Using a DO loop, we will coninutally 
  iterate through the hash object to find all the matches
*/

  DO while (r ne 0);
    IF h.find_next(key:KeyL)=0 then output;
    h.has_next(result:r);
  END;

  drop r;

RUN;
