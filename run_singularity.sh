#!/usr/bin/env bash
# ShixiangWang@2020
# w_shixiang@163.com

GISTIC_LOC=/opt/GISTIC          # DONT change this position, it refer to docker path
OUTDIR=`pwd`/test_results       # Change it if necessary

echo --- creating output directory ---
#basedir=<set_your_result_directory_here>
basedir=$OUTDIR
mkdir -p $basedir
echo output directory is $basedir

echo --- running GISTIC ---
echo Set input file paths...
## input file definitions
#segfile=/path/to/your/input.seg
segfile=$GISTIC_LOC/examplefiles/segmentationfile.txt

## reference file
refgenefile=$GISTIC_LOC/refgenefiles/hg19.mat
# Available reference list
# hg16.mat/hg17.mat/hg18.mat/hg19.mat
# hg19.UCSC.add_miR.140312.refgene.mat
# hg38.UCSC.add_miR.160920.refgene.mat

echo Starting...
DOCKER_OUTDIR="$GISTIC_LOC"/run_result

singularity run --containall --bind $basedir:$DOCKER_OUTDIR docker://shixiangwang/gistic \
  -b $DOCKER_OUTDIR -seg $segfile -refgene $refgenefile \
  -rx 0 -genegistic 1 -smallmem 1 -broad 1 -brlen 0.5 -twosize 1 \
  -armpeel 1 -savegene 1 -maxseg 10000 -conf 0.99

## More about these options, please read 
## ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTICDocumentation_standalone.htm
## https://www.genepattern.org/modules/docs/GISTIC_2.0
