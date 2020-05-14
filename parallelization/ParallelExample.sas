/* Use MPConnect to manually thread a datastep operation. Split rows of data set,use multiple RSUMBIT sessions to handle each grouping of rows,
   then recombine in master session */

%macro threadDS(path,ds,nthreads);
/*Create a common library for the dataset to reside in so the rsubmit sessions can access it.  rsbumits DO NOT share work
  libraries*/
libname common "&path.";

/*Use _N_ to create a counter for the dataset.  If you already have something you can use as a rowid, use that instead! It will save
  one read/write.*/

data &ds._in; 
  set common.&ds.; 
  rowID=_n_; 
run;

/*Now create buckets based on the number of threads you are going to use each group represents a bucket of code*/
proc rank data=&ds._in out=common.&ds._in groups=&nthreads.;
  var rowID;
  ranks thread;
run;

/*Tell SAS how to sign on.  If it is a server use options sascmd='!sascmd'.  Otherwise use
*%let rc=%sysfunc(grdsvc_enable(_all_, resource=SASApp))*/

/*%let rc=%sysfunc(grdsvc_enable(_all_, resource=SASApp));*/
options sascmd='!sascmd';


/*Create a loop to the number of groups we have*/
%do thread = 1 %to &nthreads.;
  signon thread&thread. connectwait=no;  /*Sign on a session and give it a unique name*/
  %syslput _ALL_ / remote=thread&thread.; /*Carry macro variables into our remote sessions*/

  rsubmit thread&thread. connectpersist=no;   

    libname common "&path.";

	data common.temp_thread&thread.;
	  set common.&ds._in;
	  where thread=&thread.-1 and name_match is not missing; /* Only load variables for a specific bucket*/
      length name_match_b 8.; /*Create new variable for what's being brough in from the hash table*/
					
	  IF _N_=1 then do;       /*Load the hash table into memory*/
        declare hash h(dataset: 'common.right_table(drop=dropme rename=(name_match=name_match_b))', multidata:'y');
	    declare hiter hi('h');
        h.defineKey('name_match_b');     
        h.defineData('name_match_b');     
        h.defineDone();     
        call missing(name_match_b);   
      END;

      rc=hi.first();          /*Search for matches*/
      DO while(rc=0);
        compged_score=name_match_b-name_match;
        IF compged_score le 0.001 then output; 
        rc=hi.next();     
      END; 
  
      drop rc name_match_b rowid thread;
    run;

  endrsubmit;   /*End block of code to be submitted to remote session*/
%END;

waitfor _all_ %do thread = 1 %to &nthreads.; thread&thread. %end;;  /*Wait for all blocks to run before appending them*/

data common.&ds._out;         /*Append the blocks together.  One should use proc append here*/
  set common.temp_thread:; 
run;

proc datasets lib=common nodetails nolist nowarn;   /*Delete all the little chunks of temp data*/
  delete temp_thread: &ds._in;
run;
quit;

proc datasets lib=work nodetails nolist nowarn;
  delete &ds._in;
run;
quit;

%mend threadDS;
%threadDS(path=c:\sasdata,ds=left_table,nthreads=2);


