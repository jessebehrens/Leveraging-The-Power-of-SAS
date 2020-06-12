/*******************************************************************************\ 
* Name: fulljoinhash.sas
* 
* Purpose: Create a full join using a hash object in SAS.  Use SQLfulljoin.sas
*          to compare results.  The only difference will be order. 
* 
* Author: Jesse Behrens
* 
* Input: work.lefttable & work.righttable from generatedata.sas
* Output: work.OutputFullHash
*
* History: 
* 03/02/2017 Initial creation of code
* 06/12/2020 VSCode Update
\*******************************************************************************/

/*Output table name*/

DATA work.OutputFullHash; 
/*Load the table that will act as the 'left' table.  Keep only the variables needed
  from the 'left' table.
*/
  set work.lefttable (drop=VarF VarG VarH VarI) end=lastobs;

/*This populates variables into our program data vector that exist in the
  dataset 'righttable.'  All variables that are being merged in must be 
  declared first.  I personally like to use the length statement, but other 
  methods work
*/

  length KeyR $5. VarJ VarN VarP VarR 8.;

/*Note: Hash objects are primarily designed to look for matches with an key.
  Hash objects are not the best for checking non-matching keys.  In doing a 
  full join we will need to create two copies of the 'right'data in memory. The 
  first object we will use to for matches.  The second object will have rows deleted
  from it when a match if found.  This will leave us a hash object with all the rows
  that exist in the 'right' table, but do not exist in the left
*/

  IF _N_=1 then do;
    declare hash h(dataset:'righttable(keep=KeyR VarJ VarN VarP VarR)',multidata:'y');
    h.defineKey('KeyR');
    h.defineData('VarJ','VarN','VarP','VarR', 'KeyR');
    h.defineDone();
    call missing(KeyR, VarJ, VarN, VarP, VarR);

    declare hash h1(dataset:'righttable(keep=KeyR VarJ VarN VarP VarR)',multidata:'y');
    declare hiter hiter('h1');
    h1.defineKey('KeyR');
    h1.defineData('VarJ','VarN','VarP','VarR', 'KeyR');
    h1.defineDone();
    call missing(KeyR, VarJ, VarN, VarP, VarR);
  END;

/*Let's look to see if there are any key matches using the find and check functions*/
  IF h.check(key:KeyL)=0 then h.find(Key:KeyL);

/*Output the row*/
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

/* Remove all the matches that were found in both tables from the second hash object*/
 IF h1.find(Key:KeyL)=0 then h1.remove(Key:KeyL);

/*We will append all the non-matches to the end of the table.  Since KeyL, VarA,..Var,E
  take on the values of the last observation in the 'left' table, we will need to switch
  them to missing.

  Using an iterator, we will parse through the 'h1' hash object and use an output 
  statement
 */

 IF lastobs=1 then do;
   rc=hiter.first();
   KeyL='';
   VarA=.;
   VarB=.;
   VarC=.;
   VarD=.;
   VarE=.;

   DO while (rc=0);
     output;
     rc=hiter.next();
   END;

 END;

  drop r rc;
RUN;
