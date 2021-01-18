# Flashlite-Trinity
Trinity performs de novo assembly of transcripts using Illumina RNA sequencing data. This software was originally developed at the Broad Institute and the Hebrew University of Jerusalem, read more about Trinity in their [user guide](https://github.com/trinityrnaseq/trinityrnaseq/wiki). 

This respository contains two workflows that run Trinity on the [University of Queensland's HPC, Flashlite](https://rcc.uq.edu.au/flashlite):

1. Trinity
    * PBS script: trinity.pbs
    * Recommended for single sample assemblies or smaller assemblies that require <500Gb memory 
    
2. Staged Trinity
    * PBS scripts: trinity_1.pbs, trinity_2.pbs, trinity_3.pbs
    * Recommended for global assemblies with multiple sample inputs 
    * Requires execution of 3 PBS scripts in sequence. This enables more efficient use of Flashlite's resources (as only the first two jobs utilize high memory), checkpointing (ability to re-run failed jobs) and longer walltimes.

Both workflows are easy to set up (use singularity containers) and make use of Flashlite's huge memory nodes and local disk space ($TMPDIR), both of which are essential for running Trinity on HPC systems.

# User Guide

1. Clone this repository into your working directory on Flashlite by:

  `git clone https://github.com/Sydney-Informatics-Hub/Flashlite-Trinity.git`
  
2. [Download a Trinity singularity container provided by the BROAD](https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/) onto Flashlite. 
   * Note, workflows have only been tested with versions [trinityrnaseq.v2.9.1.simg](https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.9.0.simg) and [trinityrnaseq.v2.11.0.simg](https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.11.0.simg). These containers are only compatible with Singularity v3.
   
3. Chose your workflow (Trinity of Staged Trinity) and edit the PBS script(s) for the workflow as instructed in the headers

4. Submit your job!

# Acknowledge us

If you use this script towards a publication, please acknowledge the Sydney Informatics Hub (or co-authorship, where appropriate), and cite Trinity.

__Suggested acknowledgement:__

The authors acknowledge the scientific and technical assistance <or e.g. bioinformatics assistance of <PERSON>> of Sydney Informatics Hub, the University of Sydney and resources and services provided by the University of Queensland.

# References

Grabherr MG, Haas BJ, Yassour M, Levin JZ, Thompson DA, Amit I, Adiconis X, Fan L, Raychowdhury R, Zeng Q, Chen Z, Mauceli E, Hacohen N, Gnirke A, Rhind N, di Palma F, Birren BW, Nusbaum C, Lindblad-Toh K, Friedman N, Regev A. Full-length transcriptome assembly from RNA-seq data without a reference genome. Nat Biotechnol. 2011 May 15;29(7):644-52. doi: 10.1038/nbt.1883. PubMed PMID: 21572440.

Haas BJ, Papanicolaou A, Yassour M, Grabherr M, Blood PD, Bowden J, Couger MB, Eccles D, Li B, Lieber M, Macmanes MD, Ott M, Orvis J, Pochet N, Strozzi F, Weeks N, Westerman R, William T, Dewey CN, Henschel R, Leduc RD, Friedman N, Regev A. De novo transcript sequence reconstruction from RNA-seq using the Trinity platform for reference generation and analysis. Nat Protoc. 2013 Aug;8(8):1494-512. Open Access in PMC doi: 10.1038/nprot.2013.084. Epub 2013 Jul 11. PubMed PMID:23845962.

Henschel R, Lieber M, Wu L, Nista, PM, Haas BJ, LeDuc R. Trinity RNA-Seq assembler performance optimization. XSEDE 2012 Proceedings of the 1st Conference of the Extreme Science and Engineering Discovery Environment: Bridging from the eXtreme to the campus and beyond. ISBN: 978-1-4503-1602-6 doi: 10.1145/2335755.2335842.
