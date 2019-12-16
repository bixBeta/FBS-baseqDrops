# get baseqdrop count files paths
files = list.files("Fluent BaseqDrops", pattern = "_count", full.names = T)

# import count files
for (i in 1:length(files)) {
  assign(paste0(strsplit(basename(files)[i], split = ".csv")[[1]][1]),
         value = read.table(files[i], header = T, sep = ","), envir = .GlobalEnv)
}


# indrop1 and indrop 2 are Reverse Complemented WL Barcodes
wl.grid.96 = expand.grid(as.character(indrop1$V1[1:96]), as.character(indrop2$V1[1:96]))
wl.grid.96$comb = paste0(wl.grid.96$Var1, wl.grid.96$Var2)

library(UpSetR)

# initialize a list 
upset.list.96 = list()

# populate the list
upset.list.96[[1]] = as.character(barcode_count_Sample2_1_YX20191028$barcode)
upset.list.96[[2]] = as.character(barcode_count_Sample2_2_YX20191028$barcode)
upset.list.96[[3]] = as.character(barcode_count_Sample2_3_YX20191028$barcode)
upset.list.96[[4]] = as.character(barcode_count_Sample2_4_YX20191028$barcode)
upset.list.96[[5]] = as.character(wl.grid.96$comb)

# annotate list 
names(upset.list.96)[1] = "YX1"
names(upset.list.96)[2] = "YX2"
names(upset.list.96)[3] = "RM1"
names(upset.list.96)[4] = "RM2"
names(upset.list.96)[5] = "whitelist.96"

# plot
upset(fromList(upset.list.96[c(1,2,5)]), order.by ="freq", text.scale = c(1, 1, 1, 1, 1.5, 1.5))
upset(fromList(upset.list.96[c(3,4,5)]), order.by = "freq", text.scale = c(1, 1, 1, 1, 1.5, 1.5))
upset(fromList(upset.list.96), order.by = "freq", text.scale = c(1, 1, 1, 1, 2, 2), number.angles = 20)

