/* Use MPConnect to manually thread a datastep operation.
			Split rows of data set,
			use multiple RSUMBIT sessions to handle each grouping of rows,
			then recombine in master session */

%macro threadDS(path,ds,nthreads);

libname common "&path.";

data &ds._in; 
  set common.&ds.; 
  rowID=_n_; 
run;

proc rank data=&ds._in out=common.&ds._in groups=&nthreads.;
  var rowID;
  ranks thread;
run;

options sascmd='!sascmd';

/*Use this line to go to grid*/
%let rc=%sysfunc(grdsvc_enable(_all_, resource=SASApp));

%do thread = 1 %to &nthreads.;
  signon thread&thread. connectwait=no;
  %syslput _ALL_ / remote=thread&thread.;

  rsubmit thread&thread. connectpersist=no;

    libname common "&path.";

	data common.temp_thread&thread.;
	  set common.&ds._in;
	  where thread=&thread.-1 and num_match is not missing; /* proc rank create the variable thread with a 0 index */
      length num_match_b 8.;
					
	  IF _N_=1 then do; 
        declare hash h(dataset: 'common.right_table(drop=dropme rename=(num_match=num_match_b))', multidata:'y');
	    declare hiter hi('h');
        h.defineKey('num_match_b');     
        h.defineData('num_match_b');     
        h.defineDone();     
        call missing(num_match_b);   
      END;

      rc=hi.first();
      DO while(rc=0);
        diff_score=num_match_b-num_match;
        IF diff_score le 0.001 then output; 
        rc=hi.next();     
      END; 
  
      drop rc num_match_b rowid thread;
    run;

  endrsubmit;
%END;

waitfor _all_ %do thread = 1 %to &nthreads.; thread&thread. %end;;

data common.&ds._out; 
  set common.temp_thread:; 
run;

proc datasets lib=common nodetails nolist nowarn;
  delete temp_thread: &ds._in;
run;
quit;

proc datasets lib=work nodetails nolist nowarn;
  delete &ds._in;
run;
quit;

%mend threadDS;
%threadDS(path=c:\sasdata,ds=left_table,nthreads=2);


