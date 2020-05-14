# Parallelization of a data step using hash tables

This code demonstrates how to split a table into N number of tables across a server or, preferably, a grid for faster processing.  Its primary goal is to demonstrate parallel jobs.  Good candidates for parallel jobs include:
<ul>
<li>%DO loops</li>
<li>Macros</li>
<li>By Groups</li>
</ul>
There are two pieces of code in this repository.  The first simply creates some fake data.  The second piece of code breaks the 'left' dataset into N parts, distributes it across the grid using rsubmits, and appends it together, 

<ul>
<li> Using rsubmit to split jobs across a server or grid</li>
</ul>
