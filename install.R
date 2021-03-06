### install regular packages



install.packages("reticulate") # python support in RMarkdown
# install.packages("ggplot2") # for plotting
install.packages(c("rmarkdown", "caTools", "bitops")) # for knitting
install.packages("shiny")
install.packages("tidyverse")
install.packages("ggthemes")
install.packages("ggrepel")
install.packages("tufte")

install.packages("devtools")
devtools::install_github('rstudio/bookdown')
devtools::install_github('pzhaonet/bookdownplus')


### install bioconductor packages
# install.packages("BiocManager")
# BiocManager::install("package")

### install GitHub packages (tag = commit, branch or release tag)
# install.packages("devtools")
# devtools::install_github("user/repo", ref = "tag")

###
# dyn.load(paste("CoolProp", .Platform$dynlib.ext, sep=""))
# source("CoolProp.R")
# cacheMetaData(1)


# setwd("/home/rstudio/work/")



'                                                                     '
'    .o8                                                  oooo  '
'   `888                                                  `888  '
'    888oooo.   .ooooo.  ooo. .oo.    .oooooooo  .oooo.    888  '
'    d88` `88b d88` `88b `888P`Y88b  888` `88b  `P  )88b   888  '
'    888   888 888ooo888  888   888  888   888   .oP`888   888  '
'    888   888 888    .o  888   888  `88bod8P`  d8(  888   888  '
'    `Y8bod8P` `Y8bod8P` o888o o888o `8oooooo.  `Y888``8o o888o '
'                  .                 d`     YD                  '
'                .o8    o8o          `Y88888P`                  '
'              .o888oo oooo   .oooooooo  .ooooo.  oooo d8b      '
'                888   `888  888` `88b  d88` `88b `888``8P      '
'                888    888  888   888  888ooo888  888          '
'                888 .  888  `88bod8P`  888    .o  888          '
'                `888` o888o `8oooooo.  `Y8bod8P` d888b         '
'                            d`     YD                          '
'                            `Y88888P`                          '
'                                                                     '
