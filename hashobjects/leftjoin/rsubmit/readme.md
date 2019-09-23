## Overview
These files demonstrate how to use rsubmit to submit a join hashtable across the grid.  The user can choose before they submit the code how many blocks they want to break it up into.  This example also uses a hash iter to check every combination as oppose to a key value.

The files are:<ul>
  <li>Create Table.sas - creates are left_table and right_table</li>
  <li>SQL.sas - which shows the SQL version</li>
  <li>ParallelHash - Shows how to break up the join across grid nodes and use hash tables</li>
  <li>Compare.sas - Compares the output of the SQL vs the Hashtable </li></ul>


Credit goes to <a href='https://github.com/statmike'>@statmike<a> for the code that allows the user to select the number of rsubmit jobs they want to submit.
