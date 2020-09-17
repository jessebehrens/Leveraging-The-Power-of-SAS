# Leveraging-The-Power-of-SAS
This repository contains code and examples of using modern methodologies in SAS9.4 and, in some cases, SAS Viya to help reduce the real-time of solving a problem.  Today, most users leverage procs and data steps that use a single core and intensive I/O operations on disk.  Over the years, SAS has released counterparts to these methodologies that better use compute resources for quicker answers.  The methods here demonstrate how to use multiple CPUs to solve a single problem for better real-time performance.  Additionally, some of the programs will leverage memory(example: HASH tables) to reduce I/O.  Statmike has a good writeup <a href="https://statmike.com/blog/toc">here</a> on types of analytical computing.  Each section will have additional details on that specific method:

<ul>
  <li>PROC DS2</li>
  <li>hash tables</li>
  <li>HPA procs</li>
  <li>SASPY</li>
  <li>parallelize independent code with rsubmits (coming soon)</li>
</ul>

As always, please reach out with any specific feedback you may have.
