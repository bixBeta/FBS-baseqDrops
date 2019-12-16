library("dplyr")

extractBCs = function(lv.matrix, lv.dist){
  idx = which(lv.matrix == lv.dist)
  sink(paste0(deparse(substitute(lv.matrix)), ".", 
              deparse(substitute(lv.dist)), ".log"))
  for (i in 1:length(idx)) {
    rownames(lv.matrix)[i] %>% print()
  }
  sink()
}

