library(UpSetR)

targets = read.table("target.txt", header = T, sep = "\t")


files  = targets$fileNames
groups = targets$group

for (i in 1:nrow(targets)) {
  assign(x =  as.character(targets$group[i]), 
         value = read.table(as.character(targets$fileNames[i]), 
                 header = F, stringsAsFactors = F, sep = "\t"),
         envir = .GlobalEnv)
}


pattern = ls(pattern = "_t")

megaList = list()
for (i in 1:length(pattern)) {
  megaList[[i]] = get(pattern[i])$V1
  names(megaList)[i] = pattern[i]
}


sets = c("S1_t1","S1_t2","S1_t3","S2_t1","S2_t2","S2_t3","S3_t1","S3_t2","S3_t3","S4_t1","S4_t2","S4_t3")
sets2 = c("S1_t1","S2_t1","S3_t1","S4_t1",
          "S1_t2","S2_t2","S3_t2","S4_t2",
          "S1_t3","S2_t3","S3_t3","S4_t3")

upset(fromList(megaList), sets = sets2, 
      mainbar.y.label = "Intersection - MEGA", 
      nsets = 12, keep.order = T, order.by = "freq", 
      empty.intersections = "on", sets.x.label = "Number of Bar Codes")

upset(fromList(megaList[c(1,4,7,10)]), order.by = "freq", mainbar.y.label = "Intersection Size - All Samples - t1", sets.x.label = "Number of Bar Codes")
upset(fromList(megaList[c(2,5,8,11)]), order.by = "freq", mainbar.y.label = "Intersection Size - All Samples - t2", sets.x.label = "Number of Bar Codes")
upset(fromList(megaList[c(3,6,9,12)]), order.by = "freq", mainbar.y.label = "Intersection Size - All Samples - t3", sets.x.label = "Number of Bar Codes")


