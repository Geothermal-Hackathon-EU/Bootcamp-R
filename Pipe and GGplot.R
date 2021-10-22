#### Now lets get to pipping and ggplots


#### first lets import some data, we can do that using the import features of RStudio or code it out:
### we will use data downloaded from UK Oil and Gas authority dataset that is publically available
### https://www.ogauthority.co.uk/data-centre/data-downloads-and-publications/field-data/
### 

field_equity_shares <- read_excel("./copy-of-2014-2020-field-equity-shares-june-2021.xlsx", 
                                       sheet = "2014-2020 field equity shares", 
                                       col_types = c("text", "text", "numeric", 
                                           "text", "date", "date", "text"), 
                                       skip = 2)

class(field_equity_shares)


### lets work with pipping '%>%', its a paradigm that allows functions or steps inside-out
## this makes writing and importantly reading code easier (especially for non programmers/ analysts)

library(dplyr)
library(skimr)
library(stringr)

skimr::skim(field_equity_shares)

## field_equity_shares <- data.frame(field_equity_shares)

# field_equity_shares %>%
#   group_by(Field.Name)%>%
#   summarise(add.hold = n())




field_equity_shares %>%
  group_by(`Field Name`)%>%
  summarise(add.hold = n())

