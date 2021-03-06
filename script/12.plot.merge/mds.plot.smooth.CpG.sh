#!bin/bash
# load module 
export MODULEPATH=/share/ClusterShare/Modules/modulefiles/noarch:/share/ClusterShare/Modules/modulefiles/centos6.2_x86_64:/share/ClusterShare/Modules/modulefiles/contrib:$MODULEPATH
source /etc/profile.d/modules.sh
module load phuluu/R/3.1.2

BASEDIR=$(dirname $0)
# INPUT="/home/darloluu/tmp/Test_Prostate/bigTables/bigTable.tsv.gz"
input=$1
# OUTPUT="/home/darloluu/tmp/Test_Prostate/bigTables/QC/MDS/"
output=$2

LOGFILE="$output/mds.plot.smooth.CpG.log"

echo "mds.plot.smooth.CpG.sh" > "$LOGFILE"
echo `date`" - Started processing $1 on $HOSTNAME" >> "$LOGFILE"
Rscript "$BASEDIR/mds.plot.smooth.CpG.r" "${input/.gz/}" "$output" 2>> "$LOGFILE"
echo `date`" - Finished the processing" >> "$LOGFILE"

