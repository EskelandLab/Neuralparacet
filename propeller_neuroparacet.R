setwd("~/Data_Visualization/EskelandLab/Github/NeuroDiffParacet/Shiny_timepoint/scRNANeuroDiffParacetD7D20/output/plots/")
library(Seurat)
library(speckle)
library(limma)
library(ggplot2)
currentjob="Revision Paracet"
DimPlot(NeuroDiffParacet.qcFilt, label = TRUE, label.size = 4, reduction = 'umap', group.by = 'orig.ident', repel = TRUE, cols =c( 'D7' = '#B60A1C','D20' = '#C0D6E4', 'D7.P100' = '#FFD700', 'D7.P200' = '#8CC2CA','D20.P100' = '#D37295', 'D20.P200' = '#8175AA'))
dev.copy(pdf,paste0("../output/plots/", currentjob,"_5.UMAP_by_origin.pdf"), height=5, width=8)
dev.off()
dev.set(dev.next())


DimPlot(NeuroDiffParacet.qcFilt, reduction = "umap", label = TRUE,group.by = "CellType", pt.size = 0.5,cols = c('P1' = '#D37295', 'P2' = '#FFC0CB', 'P3' = '#8175AA', 'P6' = '#FFC966','P9' = '#8CC2CA','P5' = '#B15928', 'P8' = '#59A14F', 'P10' = '#C0D6E4', 'P7' = '#FFD700', 'P4' = '#A3ECB9', 'P11' = '#CCCCCC','P12' = '#F28E2B','P13' = '#B60A1C'))##+theme(text=element_text(size=16,  family="Arial"))
NeuroDiffParacet.qcFilt <- readRDS("../RDSFiles/NeuroDiffParacetFinal_EndofPipe_Final_NeuroDiffParacet.qcFilt.rds")
# Get some example data which has two groups, three cell types and two 
# biological replicates in each group
cell_info <- speckle_example_data()

cell_info <- data.frame(CellType = NeuroDiffParacet.qcFilt$CellType,
                        sample = NeuroDiffParacet.qcFilt$orig.ident,
                        group = NeuroDiffParacet.qcFilt$orig.ident)
head(cell_info)

xc <- propeller(clusters = cell_info$clusters, sample = cell_info$samples, 
          group = cell_info$group)
xc
# Plot cell type proportions
plotCellTypeProps(clusters=cell_info$clusters, sample=cell_info$samples)


# Run propeller testing for cell type proportion differences between the two 
# groups
xc <- propeller(clusters = NeuroDiffParacet.qcFilt$orig.ident, sample = NeuroDiffParacet.qcFilt$CellType, 
          group = NeuroDiffParacet.qcFilt$orig.ident)
plotCellTypeProps(clusters=cell_info$cluster, sample=cell_info$samples)

propeller(NeuroDiffParacet.qcFilt)
# Plot cell type proportions
cluster_colors <- c('P1' = '#D37295', 'P2' = '#FFC0CB', 'P3' = '#8175AA', 'P6' = '#FFC966','P9' = '#8CC2CA',
                    'P5' = '#B15928', 'P8' = '#59A14F', 'P10' = '#C0D6E4', 'P7' = '#FFD700', 'P4' ='#B60A1C' , 
                    'P11' = '#F28E2B','P12' = '#CCCCCC','P13' = '#A3ECB9')

####################################
# Assuming you have a Seurat object named "seuratObj"

# Define the original identities that correspond to control and treatment groups
controld7<- "D7"
controld20 <- "D20"
treatmentd7<- c("D7.P100")
treatmentd20 <- c("D20.P100")
seuratObj <- NeuroDiffParacet.qcFilt


set.seed(1234)
# Create a new metadata column called "group" and assign values based on original identities
seuratObj$group <- NA
seuratObj$group[seuratObj$orig.ident %in% controld7] <- "controld7"
seuratObj$group[seuratObj$orig.ident %in% treatmentd7] <- "treatmentd7"
seuratObj$group[seuratObj$orig.ident %in% controld20] <- "controld20"
seuratObj$group[seuratObj$orig.ident %in% treatmentd20] <- "treatmentd20"
library(openxlsx)
# Run propeller testing for cell type proportion differences between the two 
# groups
xc <- propeller(clusters = seuratObj$CellType, sample = seuratObj$orig.ident, 
                group = seuratObj$group)
write.csv(xc,"coontrold7vstreatmentd7_p100_propeller.csv")
xc
plotCellTypeProps(clusters=seuratObj$orig.ident, sample=seuratObj$group)

# Plot cell type proportions
currentjob="Revision2023"
xp <- plotCellTypeProps(clusters=seuratObj$CellType, sample=seuratObj$group ) +
  scale_fill_manual(values = cluster_colors) + theme_classic()
dev.copy(pdf,paste0("../plots/", currentjob,"_1_propellerplot_ControlvsTreatmenttimewise.pdf"), height=5, width=8)
dev.off()
















