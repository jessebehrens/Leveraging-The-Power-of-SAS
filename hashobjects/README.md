The code in the hashobjects folder is meant to show SAS users another way to join data:
   1) Data step match-merge
   2) SQL join
   
Datastep hash objects serve as a way for the user to bypass the need for indexes and sorts as preliminary work to a lengthy join, and possible reduce the time it takes to join two tables together.  Hash objects achieve their results by placing a table into system memory. 

The examples in the hashobjects folder are meant to server as syntax examples for any case you may have.  They are not meant to serve as examples for possible time gain.
