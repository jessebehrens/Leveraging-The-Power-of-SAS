proc sort data=SQL_Output;
by key num_match randomvalue diff_score;
run;

proc sort data=common.left_table_out;
by key num_match randomvalue diff_score;
run;

proc compare data=sql_output compare=common.left_table_out;
run;
