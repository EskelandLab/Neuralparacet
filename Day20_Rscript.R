setwd('30_SARTools_d20')

annot <- read.delim('../ref/Biomart_ensembl_for_R.txt')
colnames(annot) <- c('gene_id', 'gene_name', 'gene_description')

write_annot <- function(filename) {
    data <- read.delim(filename, check.names=F) 
    merge_data <- merge(unique(annot), data, by.x='gene_id', by.y='Id')
    write.table(merge_data, gsub('tables', 'annot_tables', filename), quote=F, row.names=F, sep='\t') 
}

write_annot('tables/d20P100vsCtrl20.complete.txt')
write_annot('tables/d20P100vsCtrl20.down.txt')
write_annot('tables/d20P100vsCtrl20.up.txt')

write_annot('tables/d20P200vsCtrl20.complete.txt')
write_annot('tables/d20P200vsCtrl20.down.txt')
write_annot('tables/d20P200vsCtrl20.up.txt')

write_annot('tables/d20P200vsd20P100.complete.txt')
write_annot('tables/d20P200vsd20P100.down.txt')
write_annot('tables/d20P200vsd20P100.up.txt')
