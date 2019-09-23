libname common 'c:\sasdata';

DATA common.left_table;
DO i=1 to 500;
  key=rand('table',.1,.25,.2,.05,.3,.09,.01); 
  num_match=rand('normal');
  IF rand('uniform') <0.05 then num_match=.;  /*Create missing*/
  randomvalue=rand('uniform');
  IF key=7 then key=.;
  IF rand('uniform') <0.05 then output;        /*Create duplicates*/
  IF key=5 then key=10; /*Changing key values to values that right table won't have*/
  If key=3 then key=17;
  output;
END;
drop i;
RUN;

/*Simulate a generic right table - we will need to rename num_match down the line.  We will do it later
  to reduce I/O.  I also created a variable called dropme to show how to load only specific variables into
  memory*/
DATA common.right_table;
DO i=1 to 150;
  key=rand('table',.1,.25,.2,.05,.3,.09,.01);
  num_match=rand('normal');
  IF rand('uniform') <0.05 then num_match=.;  /*Create missing*/
  dropme=rand('uniform');  /*Variable to be dropped*/
  randomvalue=rand('uniform'); /*This value should not be loaded since we don't call it any hash*/
  IF key=7 then key=.;
  IF rand('uniform') <0.05 then output;        /*Create duplicates*/
  output;
END;
drop i;
RUN;
