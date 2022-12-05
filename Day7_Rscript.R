setwd('30_SARTools_d7')

annot <- read.delim('../ref/Biomart_ensembl_for_R.txt')
colnames(annot) <- c('gene_id', 'gene_name', 'gene_description')

write_annot <- function(filename) {
    data <- read.delim(filename, check.names=F) 
    merge_data <- merge(unique(annot), data, by.x='gene_id', by.y='Id')
    write.table(merge_data, gsub('tables', 'annot_tables', filename), quote=F, row.names=F, sep='\t') 
}

write_annot('tables/d7P100vsCtrl7.complete.txt')
write_annot('tables/d7P100vsCtrl7.down.txt')
write_annot('tables/d7P100vsCtrl7.up.txt')

write_annot('tables/d7P200vsCtrl7.complete.txt')
write_annot('tables/d7P200vsCtrl7.down.txt')
write_annot('tables/d7P200vsCtrl7.up.txt')

write_annot('tables/d7P200vsd7P100.complete.txt')
write_annot('tables/d7P200vsd7P100.down.txt')
write_annot('tables/d7P200vsd7P100.up.txt')
