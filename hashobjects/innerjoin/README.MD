## Overview
The code in this repository shows different ways to produce an inner join between two datasets.  An inner join returns rows between the two tables that satisfy the join condition. 
There are four pieces of code in this repository:</br>  
1) <b>Generatedata.sas</b>: Simulates data for SQLinnerjoin.sas and Innerjoinhash.sas  </br>
2) <b>innerjoinhash.sas</b>: Uses hash objects within the SAS data step to perform a inner join. 
3) <b>SQLinnerjoin.sas</b>: Performs an inner join using PROC SQL.
4) <b>DS2InnerHash.sas</b>: Uses hash objects within PROC DS2 to perform an inner join across multiple threads.</br>  
<b>My recommendation</b> is to try the hash method on your data.  I believe in most cases you will see <b>great</b> improvements over any other type of join available in SAS.  
