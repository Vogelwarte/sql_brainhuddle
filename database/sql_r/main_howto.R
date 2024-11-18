#### Stefan Hofstetter, November 10th, 2024 ####
#### main ####

# Load libraries and helper functions #
source("src/renv_manage.R")
source("src/settings.R")
## Read environ (if not in env - is stored in $home)
readRenviron(".Renviron")
source("src/db_connection.R")

#### create db only as admin ####
db_name <- "playground"
#source("src/db_create_db.R")
schema_name <- "shof"
source("src/db_create_schema.R")
source("src/db_create_table.R")
source("src/db_insert_data.R")
source("src/db_select_data.R")
### disconnect
dbDisconnect(con)
