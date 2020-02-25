##Builds a network based on pre-prepared nodes (materials, processes, dispositions) and links (flows of materials)
##for CDD materials described in Townsend et al. 2019.
##Uses networkD3 to generate the Sankey chart and writes it to html for better readability and amounts
#viewable via hovering over flow
require(networkD3)
require(readxl)

excel_file <- "CDDPathSankey.xlsx"
cddnodes <- as.data.frame(read_excel(excel_file, sheet='Nodes', col_names = T)[,"name"])
cddnodegroups <- as.data.frame(read_excel(excel_file, sheet='Nodes', col_names = T)[,"nodegroup"])
cddlinks <- as.data.frame(read_excel(excel_file, sheet='Links', col_names = T))
#Convert to metric tons then divide by million to get million metric tons
cddlinks$value <- (cddlinks$value*0.907185)/1E6

nodegroups <- as.vector(unique(cddnodegroups$nodegroup))

sankey = sankeyNetwork(Links = cddlinks, Nodes = cddnodes, Source = "source",
                       Target = "target", Value = "value", NodeID = "name",
                       units = "MMT",fontSize = 14, nodeWidth = 30)

#save to html
library(magrittr)
saveNetwork(sankey,file = 'CDDSankey.html')

