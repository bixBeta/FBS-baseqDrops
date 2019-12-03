#!/usr/bin/env Rscript

# accept command line arguments
arg <-  commandArgs(trailingOnly = T)
suppressPackageStartupMessages(library(dplyr))

# usage 
if (length(arg)==0) {
  print(" Usage = Rscript extractBCs.R < whitelist.txt > ")  
  stop("Please supply the umi-tools whitelist file !!! \n", call.=FALSE)
  
} 

# read in white list
whitelist = read.table(arg[1], sep="\t")

################################################################################
######################### PROCESS WHITELIST IMPORT #############################
################################################################################

for (i in 1:nrow(whitelist)) {
  assign(paste0("l", i, ".id"), value = whitelist[i,2],
         envir = .GlobalEnv
  )
  assign(paste0("l", i, ".val"), value = whitelist[i,4],
         envir = .GlobalEnv
  )
}


for (i in 1:nrow(whitelist)) {
  
  assign(paste0("df.", i),  
         value =  data.frame(strsplit(x = as.character(get(paste0("l", i, ".id"))), split = ","), 
                             as.numeric(unlist(strsplit(x = as.character(get(paste0("l", i, ".val"))), split = ",")))),
         envir = .GlobalEnv  
         
  )
}



for (i in 1:nrow(whitelist)) {
  assign(x = paste0("df.", i),
         value = `colnames<-`((get(paste0("df.", i))),value = c("bc","val")),
         envir = .GlobalEnv)
}

# barcode count cutoff used here is 50, change this number if desired;

for (i in 1:nrow(whitelist)) {
  
  assign(paste0("filtered",i), 
         value = get(paste0("df.",i)) %>% filter((.[,2] > 50)) ,
         envir = .GlobalEnv)
}

V2 <- vector()
V4 <- vector()

for (i in 1:nrow(whitelist)) {
  V2[i] = paste(as.character(get(paste0("filtered",i))$bc),collapse = ",")
  V4[i] = paste(as.character(get(paste0("filtered",i))$val),collapse = ",")
}

wl2 = whitelist[,c(1,3)]

wl2$V2 = V2
wl2$V4 = V4

wl2 = wl2 %>% select(1,3,2,4)


write.table(wl2, paste0("Filtered_", arg[1]), 
           quote = F, sep = "\t", col.names = F, row.names = F)

# pattern2 = ls(pattern = "filtered")

# extracted.bcs = suppressWarnings(bind_rows(mget(pattern2)))
# extracted.bcs = distinct(extracted.bcs)
# write.table(extracted.bcs, paste0("extracted.bcs.", arg[1], ".txt"), sep = "\t", quote = F, col.names = NA)

