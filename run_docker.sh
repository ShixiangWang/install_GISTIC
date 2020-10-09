#!/usr/bin/env bash
CURRENT_DIR=$(cd `dirname $0`; pwd)

echo --- creating output directory ---
basedir=`pwd`/<set_your_result_directory_here>
mkdir -p $basedir

echo --- running GISTIC ---
## input file definitions
segfile=/path/to/your/input.seg
## reference file
refgenefile=`pwd`/refgenefiles/hg38.UCSC.add_miR.160920.refgene.mat

sudo docker run --rm -v $CURRENT_DIR:/opt/GISTIC/ \
  shixiangwang/gistic -b $basedir -seg $segfile -refgene $refgenefile \
  -rx 0 -genegistic 1 -smallmem 1 -broad 1 -brlen 0.5 -twosize 1 \
  -armpeel 1 -savegene 1 -maxseg 10000 -conf 0.99

## More about these options, please read 
## ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTICDocumentation_standalone.htm
## https://www.genepattern.org/modules/docs/GISTIC_2.0