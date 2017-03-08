/******************************************************************************\ 
* Name: DS2lefthash.sas
* 
* Purpose: Create a left join using a hash object in SAS with PROC DS@.  Use 
*          SQLleftjoin.sas to compare results.  The only difference will 
*          be order.
* 
* Author: Jesse Behrens
* 
* Input: work.lefttable & work.righttable from generatedata.sas
*
* History: 
* 03/08/2017 Initial creationg of code 
\******************************************************************************/

/*Call proc DS2 and create a thread called LeftHashDS2*/
PROC DS2;
  thread LeftHashDS2 / overwrite=yes;

/* Declare the hash package
   Define the characteristics of new variables of the variables from the hash table 
*/

    declare package hash h();
    declare float VarJ VarN VarP VarR;
    declare char(5) KeyR;

/*Define the properties of the hash object.  locktable=share is important here  
  since multiple threads will need to read the same table
*/
    method init();
      h.keys([KeyR]);
	  h.data([VarJ VarN VarP VarR KeyR]);
      h.dataset('{select * from work.righttable {options locktable=share}}');
      h.multidata();
      h.defineDone();
    end;

/*Load work.lefttable.  The set statement uses FedSQL to select the variables
  we went to keep from work.lefttable
*/
	method run();
      set {select KeyL, VarA, VarB, VarC, VarD, VarE from work.lefttable};
/*Find the first match to the key and output*/

	  IF h.find([KeyL],[VarJ VarN VarP VarR KeyR])=0 then do;
	    output;

/*If there was an initial match, use a DO loop to look for more and output them
  as well*/

        DO while (h.has_next()=0);
		  h.find_next();
		  output;
		END;
	  END;

/*If there is no matching key, output the row without any matches*/
	 ELSE output;

	end;
  endthread;

/*Call the threaded code, LeftHashDS2.  This will execute across 12 threads and
  create an output dataset called OutputLeftHashDS2
*/
  DATA work.OutputLeftHashDS2 / overwrite=yes;
		declare thread LeftHASHDS2 LeftHASHDS2_instance;
		method run();
			set from LeftHASHDS2_instance threads=12;
		end;
  ENDDATA;
RUN;
QUIT;
