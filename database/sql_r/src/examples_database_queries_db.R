#### examples for database queries for Stefan' SQL brainhuddle ####
#### Patrick Scherler, October 31st, 2024 ####

### code for exemplary database query and fixing data flaws without a proper database ###
# set wd
setwd("~/_vowa/projects/sql_brainhuddle/rotmilan/")

# packages

library(readxl)
library(tidyverse)
library(dplyr)

#### Example: simple database query to extract location of settlement (first) nest for birds tagged as nestlings

# read needed data files
#lh <- read_csv("individual_life_history.csv") # read life history file to get list of individuals
lh <- tbl(con, "individual_life_history")

#nl <- read_csv("nest_list.csv")
nl <- tbl(con, "nest_list")

# ny <- read_csv("join_table_year_nests.csv")
ny <- tbl(con, "join_table_year_nests")

#generate list of tagged juveniles
tagged_juvs <-  lh %>% filter(age =="1CY" & !is.na(transm_gsm)) %>% dplyr::select(bird_id) #filter individuals that have a transmitter number and were in their first calendar year (1CY) when tagged

# filter first nest ID and join with list of tagged juveniles
### slice...
# first_nest <- ny %>% mutate(nest_id = as.numeric(nest_id))  %>% filter(!is.na(nest_id)) %>% arrange(bird_id, year) %>% group_by(bird_id) %>% slice(1) %>% dplyr::select(-year) #filter only numerical nest ids, group by bird and extract the first value
first_nest <- ny %>%
  mutate(nest_id = as.numeric(nest_id)) %>%
  filter(!is.na(nest_id)) %>%
  arrange(bird_id, year) %>%
  group_by(bird_id) %>%
  filter(row_number() == 1) %>%  # Equivalent to slice(1)
  dplyr::select(-year)


tagged_juvs <- tagged_juvs %>% left_join(first_nest) # join first nest ID to list of tagged juveniles

# attach the nest location based on nest_id
nest_coord <- nl %>% mutate(nest_id = ID) %>% dplyr::select(nest_id, coordX, coordY) %>% distinct() # extract coordinates and nest_id from nest list
settlement_locations <- tagged_juvs %>% left_join(nest_coord) %>% filter(!is.na(nest_id)) # join nest locations with list of settlers by nest_id

sql <- "SELECT distinct  min(ilh.bird_id) as bird_id, min(nl.\"ID\") as nest_id,  min(nl.\"coordX\") as \"CoordX\", min(nl.\"coordY\") as \"CoordY\"
FROM nest_list nl
left join join_table_year_nests ny on nl.\"ID\" = ny.nest_id
left join individual_life_history ilh on ilh.bird_id = ny.bird_id
where ilh.age = '1CY' and ilh.transm_gsm is not null
group by ilh.bird_id
order by 1;"

settlement_query <- dbGetQuery(con, sql)

settlement_locations_short <- nl %>%
  left_join(ny, by = c("ID" = "nest_id")) %>%
  left_join(lh, by = c("bird_id" = "bird_id")) %>%
  filter(age == '1CY', !is.na(transm_gsm)) %>%
  group_by(bird_id) %>%
  summarize(
    bird_id = min(bird_id),
    nest_id = min(ID),
    CoordX = min(coordX),
    CoordY = min(coordY)
  ) %>%
  distinct() %>%
  arrange(bird_id)

print(settlement_locations_short %>% show_query() )

settlement_locations_df <- settlement_locations_short %>% collect()

write_csv(settlement_locations_df, "settlement_locations_db.csv") # save dataframe

