PROC SQL noprint;
  create table SQL_output as
  select a.*, b.num_match-a.num_match as diff_score
  from common.left_table a, common.right_table b
  where missing(a.num_match)=0
  and calculated diff_score <= 0.001
;QUIT;
