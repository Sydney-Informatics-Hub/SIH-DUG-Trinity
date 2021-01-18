#! /bin/bash
#rj name=runWoy queue=sihtri mem=119G features=centos7 runtime=48  

#mem=128G cpus=64 runtime=48 
#module add glib2/2.14.5
module add singularity/3.5.1

mem='120G'

# Set trap
# EXIT runs on any exit, signalled or not.
finish(){
                echo "$(date) : Archiving trinity workdir/outdir in ${out} and ${in}"
		echo "tarring workdirs"
                #tar -cf ${out}/trinity_workdir_1.tar ${out}/trinity_workdir
                #tar -cf ${out}/trinity_outdir_1.tar ${out}/trinity_outdir
		echo "Tarring read partitions"
                #tar -cf ${out}/read_partitions.tar ${out}/trinity_outdir/read_partitions
		#rm -rf ${out}/trinity_outdir/read_partitions
                echo "$(date) : Finished archiving trinity_workdir_1 and trinity_outdir_1"
}
trap finish EXIT

echo "Setting variables..."
# Set variables
in=/p9/mcc_sihtri/nat
cd ${in}
first=${in}/Woylie/Woylie_8625_S1_R1_trimmed_P.fastq.gz,${in}/Woylie/woylie_heart_S6_R1_trimmed_P.fastq.gz,${in}/Woylie/woylie_pskin_S1_R1_trimmed_P.fastq.gz,${in}/Woylie/woylie_tongue_S2_R1_trimmed_P.fastq.gz
second=${in}/Woylie/Woylie_8625_S1_R2_trimmed_P.fastq.gz,${in}/Woylie/woylie_heart_S6_R2_trimmed_P.fastq.gz,${in}/Woylie/woylie_pskin_S1_R2_trimmed_P.fastq.gz,${in}/Woylie/woylie_tongue_S2_R2_trimmed_P.fastq.gz

out=${in}/woylie_global_trinity2
mkdir -p ${out}

# Create TEMP directory 
export TRINITY_WORKDIR=${out}/trinity_workdir
mkdir -p ${TRINITY_WORKDIR}

# Create output directory (all data here)
export TRINITY_OUTDIR=${out}/trinity_outdir
mkdir -p ${TRINITY_OUTDIR}

myhome=/d/home/sihtri/sihtri_nathanielb/
dughome=/d/sw/Modules/3.2.7/init/

echo "Testing Singularity..."
#singularity exec -B ${out} -B ${in} trinity.img env 
singularity exec -B ${dughome} -B ${myhome} -B ${in} trinity.img pwd

# Run trinity, stop after inchworm, do not run chrysalis
echo "Running Trinity..."
singularity exec -B ${dughome} -B ${myhome} -B ${in} trinity.img Trinity \
		--seqType fq \
                --max_memory ${mem} \
                --left ${first} \
                --right ${second} \
                --CPU 272 \
                --workdir ${TRINITY_WORKDIR} \
                --output ${TRINITY_OUTDIR} \
                --verbose

echo "$(date) : Finished trinity..."
