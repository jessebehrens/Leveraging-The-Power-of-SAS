## Overview
The code in this repository shows different ways to produce a left join between two datasets.  A left join returns rows between the two tables that satisfy the join condition as well as unmatched rows from the left table. 
There are four pieces of code in this repository:</br>  
1) <b>Generatedata.sas</b>: Simulates data for SQLleftjoin.sas and leftjoinhash.sas  </br>
2) <b>leftjoinhash.sas</b>: Uses hash objects within the SAS data step to perform a left join. 
3) <b>SQLleftjoin.sas</b>: Performs a left join using PROC SQL.
4) <b>DS2leftHash.sas</b>: Uses hash objects within PROC DS2 to perform a left join across multiple threads.</br>  
<b>My recommendation</b> is to try the hash method on your data.  I believe in most cases you will see <b>great</b> improvements over any other type of join available in SAS.  
