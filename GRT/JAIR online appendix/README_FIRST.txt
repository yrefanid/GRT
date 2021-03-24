This tar file contains the following files:

grt.gz: 	The executable of GRT v.2.0
grt.tar.gz: 	The source code of GRT v.2.0
altalt.gz: 	The executable of ALTALT used in the experiments
ff.gz: 		The executable of FF used in the experiments
ff_puzzle.gz: 	The executable of FF used in the puzzle domain (with a bug been corrected)
hsp.gz: 	The executable of HSPused in the experiments
stan.gz: 	The executable of STAN used in the experiments
scripts.tar.gz: The scripts that have been used to run the planners
domains.tar.gz: The domain and problem files used in the experiments
Data2000.zip: 	The results in zipped Excel-2000 format
Data97.zip: 	The results in zipped Excel-97 format
data.tar.gz: 	The original results, as they have been produced by the planners.



In order to reproduce the experiments, you have to do the following:

1) Create a directory in a SUN UNIX machine having Solaris Operating System.

2) Download in this directory the executable files of the planners.

3) Download in this directory the domains' file domains.tar.gz.

4) Download in this directory the scripts' file scripts.tar.gz

5) Unzip and untar the zipped tar files, using the following commands:

gunzip domains.tar.gz

gunzip scripts.tar.gz

tar -xvf domains.tar

tar -xvf scripts.tar

6) Set execution permissions for the executable and the script files.

You can use the script files to reproduce the experiments.
In case you want to run a planner to a specific problem,
you can run the planner from the command line.
If you run any planner from the command line and without arguments,
it displays information about the necessary arguments.
However, it is helpful to have a look in the script files.

In case you have not a UNIX machine available, please 
contact one of the authors, so that you will 
be given an account in our machines.

In case of any other problem, comment etc., please contact 
again any one of the authors.


