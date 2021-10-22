#### a look at installing and loading packages



## install.packages() is used to download packages from the CRAN
## you need to install "devtools" package from: CRAN to access packages that are
## not realeased on to CRAN, or are Dev versions of CRAN packages. 
## You need to download and install RTools from https://cran.r-project.org/bin/windows/Rtools/
## Mac and Linux should be able to download devtools directly

### install one package
install.packages("tidyverse")


## install list of packages
install.packages(c("devtools","data.table","lubridate"))


library(tidyverse)






