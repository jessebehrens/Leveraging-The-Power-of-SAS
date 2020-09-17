## Overview

The code in the subfolders of hashobjects is meant to show SAS users an efficient way to join two datasets together outside of the data step match-merge and SQL join.  Each subfolder contains different methods for executing different join and merge types.
   
Data step and DS2 hash objects offer two distinct advantages:    
   1) They eliminate the need for preprocessing the data with indexes and sorts.     
   2) They have the <i>potential</i> to greatly reduce processing time.  

The examples in the hashobjects folder are designed to help the user learn hash objects and their syntax leveraging both the data step and PROC DS2.  Additionally, I have provided a corresponding SQL procedure for each hash object method to serve as a comparison between the three techniques.  


For more information on SAS hash objects, please see this <a href='https://support.sas.com/documentation/cdl/en/lecompobjref/69740/HTML/default/viewer.htm#p0ae2of2fa94xmn1bajgqxczla8u.htm'>link</a>

## DS2 and Hash objects
PROC DS2 is an advance data manipulation tool in SAS.  In its most basic form, PROC DS2 is able to maniluplate data across multiple cores on a single SAS machine; the data step manipulates data across a single core.  However, for each core we use in our PROC DS2, we must create an additional copy of the hash object in memory.  However, the trade off in time efficency may be worth the cost in additional resources for your particular case.  

You can read more about PROC DS2 <a href='https://support.sas.com/documentation/cdl/en/ds2ref/69739/HTML/default/viewer.htm'>here</a>.

<b>Final Note</b>:  These methods have been tested against SAS9.4 and not SAS Viya's CAS engine.  I will deliver and example shortly, but please feel free to contact me in the meantime.
