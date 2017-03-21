#!bin/bash -e
# usage: bash methyldackel.sh input output reference

# load module 
export MODULEPATH=/share/ClusterShare/Modules/modulefiles/noarch:/share/ClusterShare/Modules/modulefiles/centos6.2_x86_64:/share/ClusterShare/Modules/modulefiles/contrib:$MODULEPATH 
export PATH=/home/phuluu/bin:$PATH
source /etc/profile.d/modules.sh
MethylDackel="/home/phuluu/methods/DNAmeth.calling.method.comparison/MethylDackel/bin/MethylDackel"
module load gi/bedtools/2.22.0

# get paramaters
# $1=aligned/PrEC/PrEC.bam
input=$1
sample=$(basename $input| cut -d. -f1)
# $2=calls/PrEC
output=$2
# GENOME="/home/phuluu/methods/darlo/annotations/hg19/hg19.fa"
GENOME=$3
# # example
# input="/home/phuluu/data/WGBS10X_new/Test_Prostate/merged/PrEC/PrEC.bam"
# sample="PrEC"
# output="/home/phuluu/data/WGBS10X_new/Test_Prostate/called/PrEC/"
# GENOME="/home/phuluu/Projects/WGBS10X_new/V02/annotations/hg19/hg19.fa"

LOGFILE="${output}/${sample}.methyldackel.meth.calling.CHT.log"

echo `date`" - CHT strands" > $LOGFILE
echo -e "#chr\tposition\tstrand\t${sample}.C\t${sample}.cov" > "${output}/${sample}.MD.strands_CHT.tsv"
cmd="""
bedtools intersect -a ${GENOME/.fa/.CHT.strands.bed} -b ${output}/${sample}.MD.strands_CHH.bedGraph -loj| awk '{OFS=\"\t\"}{if(\$11==-1){\$11=\$12=0}; print \$1,\$3,\$6,\$11,\$11+\$12}' >> ${output}/${sample}.MD.strands_CHT.tsv
"""
echo $cmd >> "$LOGFILE"; eval $cmd 2>> "$LOGFILE"; echo -e `date`" Finished - CHT strands\n" >> $LOGFILE

echo "*** Zip output file"  >> $LOGFILE
cmd="""
gzip ${output}/${sample}.MD.strands_CHT.tsv;
"""
echo $cmd >> "$LOGFILE"; eval $cmd 2>> "$LOGFILE"; echo -e `date`" Zip output\n" >> $LOGFILE
