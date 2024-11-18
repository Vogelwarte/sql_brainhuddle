#### examples for database queries for Stefan' SQL brainhuddle ####
#### Patrick Scherler, October 31st, 2024 ####

### code for exemplary database query and fixing data flaws without a proper database ###
# set wd
setwd("~/_vowa/projects/sql_brainhuddle/rotmilan/")

# packages

library(readxl)
library(tidyverse)


#### Example: simple database query to extract location of settlement (first) nest for birds tagged as nestlings

# read needed data files
lh <- read_csv("individual_life_history.csv") # read life history file to get list of individuals
nl <- read_csv("nest_list.csv")
ny <- read_csv("join_table_year_nests.csv")

#generate list of tagged juveniles
tagged_juvs <-  lh %>% filter(age =="1CY" & !is.na(transm_gsm)) %>% dplyr::select(bird_id) #filter individuals that have a transmitter number and were in their first calendar year (1CY) when tagged

# filter first nest ID and join with list of tagged juveniles
first_nest <- ny %>% mutate(nest_id = as.numeric(nest_id))  %>% filter(!is.na(nest_id)) %>% arrange(bird_id, year) %>% group_by(bird_id) %>% slice(1) %>% dplyr::select(-year) #filter only numerical nest ids, group by bird and extract the first value
tagged_juvs <- tagged_juvs %>% left_join(first_nest) # join first nest ID to list of tagged juveniles

# attach the nest location based on nest_id
nest_coord <- nl %>% mutate(nest_id = ID) %>% dplyr::select(nest_id, coordX, coordY) %>% distinct() # extract coordinates and nest_id from nest list
settlement_locations <- tagged_juvs %>% left_join(nest_coord) %>% filter(!is.na(nest_id)) # join nest locations with list of settlers by nest_id

write_csv(settlement_locations, "settlement_locations.csv") # save dataframe

