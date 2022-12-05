reqPkg = c("data.table", "Matrix", "hdf5r", "ggplot2", "gridExtra",
           "glue", "readr", "RColorBrewer", "R.utils", "Seurat")
newPkg = reqPkg[!(reqPkg %in% installed.packages()[,"Package"])]
if(length(newPkg)){install.packages(newPkg)}
reqPkg = c("shiny", "shinyhelper", "data.table", "Matrix", "hdf5r", 
          "ggplot2", "gridExtra", "magrittr", "ggdendro")
newPkg = reqPkg[!(reqPkg %in% installed.packages()[,"Package"])]
if(length(newPkg)){install.packages(newPkg)}

devtools::install_github("SGDDNB/ShinyCell")





library(Seurat)
library(ShinyCell)


NeuroDiffParacet = readRDS("/Users/ankushs/EskelandLab/Github/NeuroDiffParacet/scRNAParacet/output/RDSFiles/NeuroDiffParacetFinal_for_cytotrace_NeuroDiffParacet.qcFilt.rds")
scConf = createConfig(NeuroDiffParacet)
makeShinyApp(NeuroDiffParacet , scConf, gene.mapping = TRUE,
             shiny.title = " Effects of Paracetamol Neuronal Differentiation - scRNA Dataset") 

#Authorizing Account


#rsconnect::deployApp('/Users/ankushs/data_visualization/singlecell/differentiation/shinyApp/')
