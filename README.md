
### Overview
To complete this high-throughput computing task the user should be familiar with the following: command-line, regular expressions, command-line data wrangling, Bash coding and Nextflow. We will use Kamiak which is a High-Performance Computing Cluster used at Washington State University. Given a FASTA file containing 66,000 protein sequences, split it into multiple files that are no larger thean 5,000 sequences per file. Using Kamiak, execute the BLAST blastp program on all 10 files and the submission of the 10 files must be automated. Summarize the Blast results by generating a tab delimited summary file containing the results. The file should have only two columns, the first being the gene name, the second being the total number of alignments matches for that gene.

### Programs used:
1. Git Bash/2.25.0
2. Java/1.8.0
3. Nextflow/19.01.0 - Bioinformatics workflow manager 
4. Blast/2.9.0 - Algorithm & program for comparing primary biological sequence information
5. SLURM - Cluster management and job scheduling system


## 1. Download this repository.
_count_sort_genes.txt file is what your tab-delimited summary file should look like_

## 2. Nextflow config file
A Nextflow configuration file is a simple text file containing a set of parameters and directives. We will utilize the nextflow.config file to launch jobs on the executor (Slurm) so that we don't have to specify in our script. 

## 3. Bash run script
This script (Project.srun) will start our project. It contains instructions for how we would like the job to be ran. The account, and partition will need to be changed to whatever the user has permission to. If you would like email updates on your job insert your email where mine is. If you do not want updates, you can remove both lines that have "mail". The remaining #SBATCH lines can remain as is. The last line tells Nextflow to run Step1.nf and use the -profile SLURM specified in the config file. <p> 
* On the Command line run: `sbatch Project.srun`  <p>
_This will run on the cluster for 5-14 hours._


## 4. Collect results
Once the job is finished, locate the files returned and verify the results are what we expected. 

Find the channel by executing: `find -name "match_ch.txt"` <p>
Which should return something similar to: <p>
./tmp/ad/398a13c0a16de70051026c1fda9df9/match_ch.txt

 Find the reuslts files by executing: <p> 
`find -name “output_results”` <p> <p>

## 5. Request a node
Request one core from the ficklin_class partition which will allow us to run commands on one of the head node.  <p>
Run: `idev --partition=ficklin_class --account=ficklin_class -t 12:00:00 ` 
  
## 7. Sort and combine files.
We will  combine the files in output_results.txt resulting in 2 columns with the gene name and the amount of times that the gene name occurred in descending order with the command:   <p>
```groovy
cat ./tmp/ad/398a13c0a16de70051026c1fda9df9/match_ch.txt | perl -p -e 's/\.\d+\t/\t/g' | awk '{print $1}' | sort | uniq -c | sort -rn | awk '{print $2"\t"$1}' > count_sort_genes.txt
```
