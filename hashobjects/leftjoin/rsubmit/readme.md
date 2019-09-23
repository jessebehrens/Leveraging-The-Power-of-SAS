These files demonstrate how to use rsubmit to submit a join hashtable across the grid.  The user can choose before they submit the code how many blocks they want to break it up into.  This example also uses a hash iter to check every combination as oppose to a key value.

The files are:
Create Table.sas - creates are left_table and right_table
SQL.sas - which shows the SQL version
ParallelHash - Shows how to break up the join across grid nodes and use hash tables
Compare.sas - Compares the results.


A lot of credit goes to <a href='https://github.com/statmike'>@statmike<a> for the code that allows the user to select the number of rsubmit jobs they want to submit.
