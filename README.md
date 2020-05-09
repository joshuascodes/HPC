# Final Project
### Agricultural and Food Systems 505 Unit 3

To complete this high-throughput computing task the user should be familiar with the following: command-line, regular expressions, command-line data wrangling, Bash coding and Nextflow. We will use Kamiak which is a High-Performance Computing Cluster used at Washington State University.

### Programs used:
1. Bash
3. Groovy
2. Java
3. Nextflow - Bioinformatics workflow manager 
4. SLURM - cluster management and job scheduling system
5. Blast - Algorithm & program for comparing primary biological sequence information

## Step1. Download this Repository.

## 2. Nextflow config file
A Nextflow configuration file is a simple text file containing a set of parameters and directives. We will utilize the nextflow.config file to launch jobs on the executor (Slurm) so that we don't have to specify in our script. 

## 3. Bash run script
This script (Job.srun) will start our project. It contains instructions for how we would like the job to be ran. The account, and partition will need to be changed to whatever the user has permission to. If you would like email updates on your job insert your email where mine is. If you do not want updates, you can remove both lines that have "mail". The remaining #SBATCH lines can remain as is. The last line tells Nextflow to run Step1.nf and use the -profile SLURM specified in the config file. On the Command line run: . <p>
sbatch Project.srun  <p>
This will run on the cluster for 5-14 hours.  




## 4. Collect results
Once the job is finished, locate the files returned and verify the results are what we expected.  Now run: <p> 
find -name “output_results” <p> <p>
Find the channel. Run: <p> find -name "match_ch.txt" <p>
Which should return something similar to: <p>
./tmp/ad/398a13c0a16de70051026c1fda9df9/match_ch.txt

# Part 2
Find the channel. Run: find -name "match_ch.txt" <p>
Which should return something similar to: <p>
./tmp/ad/398a13c0a16de70051026c1fda9df9/match_ch.txt

## 5. Request a node
Request one core from the ficklin_class partition which will allow us to run commands on one of the head node.  <p>
Run: idev --partition=ficklin_class --account=ficklin_class -t 12:00:00  
## 6. Sort and combine files.
We will  combine the files in output_results.txt resulting in in 2 columns with the gene name and the amount of time the gene name occurred in descending order with the command:   <p>
cat ./tmp/ad/398a13c0a16de70051026c1fda9df9/match_ch.txt | perl -p -e 's/\.\d+\t/\t/g' | awk '{print $1}' | sort | uniq -c | sort -rn | awk '{print $2"\t"$1}' > count_sort_genes.txt

