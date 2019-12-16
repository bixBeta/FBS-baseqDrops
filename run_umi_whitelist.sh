#!/bin/sh
if [ "$1" = "help" ] || [  -z $1  ]; then
    echo ""
    echo "--------------------------------------------------------------------------------------------------------"
    echo "  To run this script, use the following syntax:"
    echo "     bash" $0 "<--error-correct-threshold[int]>"
    echo "--------------------------------------------------------------------------------------------------------"
    echo ""
    echo ""
    echo ""
    exit 1

else

  for i in *_R1.fastq.gz
  do
    iSUB=`echo $i | cut -d "_" -f1-4`
    umi_tools whitelist --stdin $i \
    --bc-pattern="(?P<cell_1>.{8,12})(?P<discard_1>GAGTGATTGCTTGTGACGCCTT){s<=2}(?P<cell_2>.{8})(?P<umi_1>.{6})T{3}.*" \
    --extract-method=regex \
    --set-cell-number=1000 \
    --error-correct-threshold $1 \
    --ed-above-threshold=discard \
    --knee-method=distance \
    --plot-prefix=${iSUB}_error_correct_th_${1}_estimateknee_whitelist \
    --log2stderr > ${iSUB}_error_correct_th_${1}_estimateknee_whitelist.txt

  done

  mkdir RESULTS_error_correct_th_${1}
  mv *.txt *.png RESULTS_error_correct_th_${1}

fi
