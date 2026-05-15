Copy/pastes from Student manual
https://uppsalauniversitet-my.sharepoint.com/my?id=%2Fpersonal%2Fanna%2Dmarta%5Fwoszczyk%5F0387%5Fstudent%5Fuu%5Fse%2FDocuments%2F1%2E%20Courses%2FGenome%20Analysis%2FPaper%20II%2FRessources%2FStudent%20Manual%202026%2D1%2Epdf&parent=%2Fpersonal%2Fanna%2Dmarta%5Fwoszczyk%5F0387%5Fstudent%5Fuu%5Fse%2FDocuments%2F1%2E%20Courses%2FGenome%20Analysis%2FPaper%20II%2FRessources

# INTRODUCTION

One of the aims of these labs is to get familiar with bioinformatics tools and methods that are commonly used when analysing sequencing data. You will proceed by re-analyzing their data in a similar way  as the authors did on the original study, and re-evaluating their biological conclusions

###1.  plan the analyses that you need to perform
###2. All the data can be found in the Sequence Read Archive (https://www.ncbi.nlm.nih.gov/sra/).
###3.  Finally, an important task during any scientific project is to document all the analyses you have done. To do so, you will create a GitHub repository where you will record codes and used methods

# PROJECT PLANNING

Your project plan should address at least the following points:
● What is the aim of your project? What question(s) do you want to answer with your research?
● What type of analyses will you perform in order to answer these questions? And in which order? Which softwares will you use? Are there any time bottlenecks? If so, can you identify any analyses that will require longer times?
● What is the time frame for your project? Can you define some time checkpoints for when you should have finished certain analyses? When do you need to have finished running all the softwares so you can start to analyse the data?
● What types of data will you be handling? How much space do you need in order to store the data? (You might not know that in advance, but pay attention to this as you work and manage your available space!)
● How will you organise your data? (see “Project Organization”)

# PROJECT ORGANIZATION

## Keeping the metadata
The process of collecting metadata starts in the lab
Since you will work with public data, you can obtain the metadata associated with the sequencing reads files from public databases and from the original article.

Since you will work with public data, you can obtain the metadata associated with the 
sequencing reads files from public databases and from the original article

## Get familiar with your data
http://www.ncbi.nlm.nih.gov/sra page and search for the SRA accession of your samples.
In the “Select” table, under “Download” click on “Metadata”. This will download a file called SraRunTable.txt that contains information about the whole dataset (not the actual data).

## Organising your working directory
Data and code should be separated.
Keep data files with unique and informative names
Symbolic links
Data files, especially big data files, should be compressed

# CODE RUNNING
All analyses should preferably be run in your home folder at UPPMAX 
(/home/<your_username>)
You should save all code you use, be it software commands, a simple bash one-liner, a longer Perl/Python script, an UPPMAX batch script, etc on GITHUB

# GITHUB

In our project, you will use GitHub to document and keep track of your analyses and code
You can keep any project-related documentation here, but most importantly you are expected to use GitHub to save your code and to keep an updated wiki on your project

Moreover, your GitHub wiki is where you can write explanations about what you are doing, why you are doing it, and what you plan to do. It should include:
● Which paper you are working with
● Your project plan
● Your goals/hypotheses
● A section for each analysis you run (quality control, assembly, RNA mapping, etc.) with explanations on methods you are using, the results you got, a short discussion about them, etc.
● Any general thoughts, discussions, speculation, etc. that you may have about the project and your overall results
● Also suggested: A daily log of what you did on each day of work

Both code and wiki must be written in a clear and organised way, with enough explanations for another person to properly understand and reproduce what you are doing.

=> WE WILL HAVE TO COPY EVERYTHING FROM UPPMAX TO GITHUB :-) **guide p16**
