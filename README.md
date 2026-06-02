# Genome Analysis Project

## Overview
This project was developed as part of the *Genome Analysis* course during my MSc in Bioinformatics at Uppsala University.

It focuses on building and applying a complete genome analysis pipeline, from raw sequencing data to genome assembly, annotation, and gene expression analysis, using reproducible workflows.

## Aim
- Process and quality-control raw sequencing data  
- Perform genome assembly and polishing  
- Annotate the genome (structural and functional)  
- Analyse RNA-seq data and differential gene expression  
- Work using structured and reproducible bioinformatics pipelines  

## Skills demonstrated
- Bioinformatics pipeline development  
- RNA-seq and genome analysis  
- Data preprocessing and quality control  
- Working in Linux environments  
- Scripting and analysis using Python and R  
- Reproducible and well-structured workflows  

---

## Project Structure
### Project Plan
* [Project Plan][project-plan]
* [Analyses & Pipeline][pipeline]
* [Data Management][dm]

### Methods
#### Data Preprocessing
* [Reads Quality Control][qc]
* [Reads Trimming][trimming]

#### Genome Assembly
* [de novo Assembly][de-novo]
* [Mapping of Illumina reads][mapping-dna]
* [Assembly polishing][polishing]
* [Assembly QC with QUAST][quast-qc]

#### Mapping and Genome Annotation
* [Mapping of RNA reads][mapping-rna]
* [Structural annotation][struct-annot]
* [Functional annotation][fun-annot]
* [Assembly completeness][busco]

#### Pattern of Gene Expression
* [RNA Reads count][reads-count]
* [Differential Gene Expression][diff-exp]

### Results
* [Data Preprocessing][res-prepro]
* [Genome Assembly][res-ass]
* [Mapping and Genome Annotation][res-map]
* [Pattern of Gene Expression][res-exp]

---

## Workflow summary
1. Raw data preprocessing and quality control  
2. Genome assembly and polishing  
3. Genome annotation  
4. RNA-seq analysis and differential expression  
5. Interpretation of results  

---

## Notes
This repository reflects my practical training in bioinformatics and my interest in applying structured, reproducible approaches to biological data analysis.

---

[home]: https://github.com/myproject/wiki/Home
[project-plan]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/Home
[pipeline]: https://github.com/anwo0387/genome-analysis-1MB462/wiki#pipeline
[dm]: https://github.com/anwo0387/genome-analysis-1MB462/wiki#pipeline

[qc]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#1-reads-quality-control
[trimming]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#2-reads-trimming

[de-novo]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#1-de-novo-assembly
[mapping-dna]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#2-mapping-of-illumina-reads
[polishing]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#3-assembly-polishing
[quast-qc]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#4-assembly-qc-with-quast

[mapping-rna]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#1-mapping-of-rna-reads
[struct-annot]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#2-structural-annotation
[fun-annot]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#3-functional-annotation
[busco]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#4-assembly-completeness

[reads-count]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#4-assembly-completeness
[diff-exp]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/02.-Methods#2-differential-gene-expression

[res-prepro]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/03.A-Results-%E2%80%90-Data-Preprocessing
[res-ass]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/03.B-Results-%E2%80%90-Genome-Assembly
[res-map]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/03.C-Results-%E2%80%90-Mapping-and-Genome-Annotation
[res-exp]: https://github.com/anwo0387/genome-analysis-1MB462/wiki/03.D-Results-%E2%80%90-Pattern-of-Gene-Expression
