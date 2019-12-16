# Cell barcode clustering

Evaluating frequency of cell barcode usage across multiple single cell datasets. Producing summary graphs and tables of cell barcodes frequencies across dataset including outliers. Submitting code to this group.

**run_umi_whitelist.sh** <br>
`Usage = bash run_umi_whitelist.sh <--error-correct-threshold[int>0]>` <br>
Performs BC extraction with error correction threshold stringency provided by the user 

**extractBCs.R** <br>
`Usage = Rscript extractBCs.R < /path/to/whitelist.txt > ` <br>
*whitelist.txt* is the output generated from `run_umi_whitelist.sh` 