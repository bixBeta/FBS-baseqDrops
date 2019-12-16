`upset.baseqDrop.R`  
Generates UpSetPlots for YX1,YX2,RM1 and RM2 samples to understand the distributions across samples when compared to whitlelist barcodes.  

`distances.R`
Calculates Levenshtein distances. Creates a matrix per sample, capturing  the lv-distances. Columns of this matrix represents the whitelist BC's and rows represents the query  sample barcodes, initially not  found  in the whitelist  barcodes  as seen in the  UpSet Plots.  

`extractFunc.R`
Extracts sample barcodes that meet the specified lv-dist criteria for  a given  sample  lv-dist matrix. <br>
Example Usage:<br>
    `extractBCs(lv.matrix = comp.RM2.lv, lv.dist = 2)` will extract BCs from RM2 sample that were at lv-dist = 2 when compared to the whitelist BCs