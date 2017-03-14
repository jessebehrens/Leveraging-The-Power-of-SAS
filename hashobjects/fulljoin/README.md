## Overview

The code in this repository shows different ways to produce a full join between two datasets.
A full join returns rows between the two tables that satisfy the join condition in addition to any unmatched rows.  There are three pieces
of code in this repository:  

1) <b>Generatedata.sas</b>: Simulates data of any size for the joins performed by SQLfulljoin.sas and fulljoinhash.sas  
2) <b>fulljoinhash.sas</b>: Uses hash objects within the SAS data step to perform a full join.  The full join is different than
                            the inner join and left join since we have to track the rows which existed in the right table but did not exist in the left table.
3) <b>SQLfulljoin.sas</b>:  Performs a full join using PROC SQL.

## What about PROC DS2 and full joins using hash objects?
DS2 can perform joins using hash objects similiarly to the data step.  The real advantage of PROC DS2 is it can distribute the work across multiple cores unlike a data step.
The trade off is that each core will need its own copy of the hash object in memory.  In the case of a full join
