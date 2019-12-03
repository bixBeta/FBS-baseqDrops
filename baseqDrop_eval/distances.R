library(dplyr)

# get  BC's unique to sample 1 and 2 
YX1.unique.BC = setdiff(barcode_count_Sample2_1_YX20191028$barcode, wl.grid.96$comb)
YX2.unique.BC = setdiff(barcode_count_Sample2_2_YX20191028$barcode, wl.grid.96$comb)

RM1.unique.BC = setdiff(barcode_count_Sample2_3_YX20191028$barcode, wl.grid.96$comb)
RM2.unique.BC = setdiff(barcode_count_Sample2_4_YX20191028$barcode, wl.grid.96$comb)


library(stringdist) 
# compute Levenshtein distances 
comp.YX1.lv = stringdistmatrix(YX1.unique.BC, wl.grid.96$comb, method = "lv")
comp.YX2.lv = stringdistmatrix(YX2.unique.BC, wl.grid.96$comb, method = "lv")

comp.RM1.lv = stringdistmatrix(RM1.unique.BC, wl.grid.96$comb, method = "lv")
comp.RM2.lv = stringdistmatrix(RM2.unique.BC, wl.grid.96$comb, method = "lv")

# saveRDS(comp.RM1.lv, "comp.RM1.lv.Rds")
# saveRDS(comp.RM2.lv, "comp.RM2.lv.Rds")
# saveRDS(comp.YX1.lv, "comp.YX1.lv.Rds")
# saveRDS(comp.YX2.lv, "comp.YX2.lv.Rds")


library(stringr)
# strip new line charater
comp.strip.YX1  =str_replace_all(YX1.unique.BC, "[\r\n]" , "")
comp.strip.YX2  =str_replace_all(YX2.unique.BC, "[\r\n]" , "")
comp.strip.RM1  =str_replace_all(RM1.unique.BC, "[\r\n]" , "")
comp.strip.RM2  =str_replace_all(RM2.unique.BC, "[\r\n]" , "")

rownames(comp.YX1.lv) = comp.strip.YX1
rownames(comp.YX2.lv) = comp.strip.YX2
rownames(comp.RM1.lv) = comp.strip.RM1
rownames(comp.RM2.lv) = comp.strip.RM2


colnames(comp.YX1.lv) = wl.grid.96$comb # wl.grid.96$comb generated using upset.baseqDrop.R
colnames(comp.YX2.lv) = wl.grid.96$comb
colnames(comp.RM1.lv) = wl.grid.96$comb
colnames(comp.RM2.lv) = wl.grid.96$comb

# save(comp.YX1.lv, comp.YX2.lv, comp.RM1.lv, comp.RM2.lv, file = "lv.matrices.w.colnamesWLandRownamesWL.Rdata")

### PLOTTING

library(reshape)
melted.YX1 =  melt(comp.YX1.lv)
colnames(melted.YX1) = c("row.YX1", "col.WL", "value")
melted.YX2 =  melt(comp.YX2.lv)
colnames(melted.YX2) = c("row.YX2", "col.WL", "value")

melted.RM1 =  melt(comp.RM1.lv)
colnames(melted.RM1) = c("row.RM1", "col.WL", "value")
melted.RM2 =  melt(comp.RM2.lv)
colnames(melted.RM2) = c("row.RM2", "col.WL", "value")


head(melted.RM2)

summary(melted.YX1$value)
summary(melted.YX2$value)
summary(melted.RM1$value)
summary(melted.RM2$value)

df.yx1 = as.data.frame(table(melted.YX1$value))
colnames(df.yx1) = c("YX1.LV", "YX1.Freq")

df.yx2 = as.data.frame(table(melted.YX2$value))
colnames(df.yx2) = c("YX2.LV", "YX2.Freq")

df.rm1 = as.data.frame(table(melted.RM1$value))
colnames(df.rm1) = c("RM1.LV", "RM1.Freq")

df.rm2 = as.data.frame(table(melted.RM2$value))
colnames(df.rm2) = c("RM2.LV", "RM2.Freq")

lv.distribution = cbind(df.yx1,df.yx2,df.rm1,df.rm2)


write.table(lv.distribution, "lv.distribution.txt", sep = "\t", col.names = T)

g1 = ggplot(data = melted.YX1, aes(x = value)) + geom_histogram(binwidth = 1) 
g2 = ggplot(data = melted.YX2, aes(x = value)) + geom_histogram(binwidth = 1) 
g3 = ggplot(data = melted.RM1, aes(x = value)) + geom_histogram(binwidth = 1) 
g4 = ggplot(data = melted.RM2, aes(x = value)) + geom_histogram(binwidth = 1) 


