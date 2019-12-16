library(dplyr)
library(magrittr)
library(insect)

files = list.files(pattern = ".log$")

last8 <- function(x){
  substr(x, nchar(x)-8+1, nchar(x))
}

firstN <- function(x){
  substr(x,1, nchar(x)-8)
}

# import files
for (i in 1:length(files)) {
  
  assign(files[i], value = read.table(files[i]), envir = .GlobalEnv)
  
}

# save object names
p1 = ls(pattern = "comp")

# remove [1]
for (i in 1:length(p1)) {
  assign(p1[i], value = get(p1[i]) %>% select(-1) %>% set_colnames("WL"), envir = .GlobalEnv)
}

# calculate WL reverse complements
for (i in 1:length(p1)) {
  assign(p1[i], value = cbind(get(p1[i]),apply(as.data.frame(get(p1[i])$WL),1,insect::rc)) , envir = .GlobalEnv)
}

# set colnames
for (i in 1:length(p1)) {
  assign(p1[i], value = get(p1[i]) %>% set_colnames(c("WL", "RC.WL")), envir = .GlobalEnv)
}

# Strip first(n-8) chars from RC.WL
for (i in 1:length(p1)) {
  assign(p1[i], value = cbind(get(p1[i]),apply(as.data.frame(get(p1[i])$RC.WL),1,firstN)) , envir = .GlobalEnv)
}

# Strip last8 chars from RC.WL
for (i in 1:length(p1)) {
  assign(p1[i], value = cbind(get(p1[i]),apply(as.data.frame(get(p1[i])$RC.WL),1,last8)) , envir = .GlobalEnv)
}

# Set colnames
for (i in 1:length(p1)) {
  assign(p1[i], value = get(p1[i]) %>% set_colnames(c("WL", "RC.WL","RC.indrop1", "RC.indrop2")), envir = .GlobalEnv)
}

system("mkdir Input_for_baseqDrops_customRUN")
setwd("Input_for_baseqDrops_customRUN")
for (i in 1:length(p1)) {
  write.table(get(p1[i]), file = paste0(p1[i],".txt"), sep = "\t", quote =F, row.names = F)
}


