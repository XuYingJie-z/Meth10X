#!/bin/bash -e

# load module 
export MODULEPATH=/share/ClusterShare/Modules/modulefiles/noarch:/share/ClusterShare/Modules/modulefiles/centos6.2_x86_64:/share/ClusterShare/Modules/modulefiles/contrib:$MODULEPATH 
export PATH=/home/phuluu/bin:$PATH
source /etc/profile.d/modules.sh
module load gi/samtools/1.2

# $1=aligned/PrEC/PrEC.bam
INPUT=$1
Sample=$(basename $INPUT| cut -d. -f1)
# $2=aligned/PrEC
OUTPUT=$2
LOGFILE="${OUTPUT}/${sample}.check.dup.marked.lane.bam.log"

echo " *** Check duplication marked lane bam" >> $LOGFILE
echo `date`" - Started processing $INPUT on $HOSTNAME" >> $LOGFILE
echo """ samtools view -H $INPUT """ >> $LOGFILE
samtools view -H $INPUT 2>> $LOGFILE
echo `date`" - Finished check duplication marked lane bam" >> $LOGFILE
