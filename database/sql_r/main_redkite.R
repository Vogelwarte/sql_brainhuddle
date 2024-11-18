# Load libraries and helper functions
source("src/renv_manage.R")
source("src/settings.R")
#### Read environ (if not in env - is stored in $home) ####
readRenviron(".Renviron")
### for local use with SQLite
#source("src/db_connection_local.R")
source("src/db_connection.R")
db_name <- "playground"

# Connect and print connection status for testing
# source("src/db_create_db.R")

### a schema is something between the database and the table - postgres specific
schema_name <- "shof"
source("src/db_create_schema.R")

#### load data from csv ####
# Define the path where the data is stored
data_path <- "../../rotmilan"
# Define an array of content names
tables <- list(
  list(csv_file_name="individual_life_history"),
  list(csv_file_name="brood_parameters"),
  list(csv_file_name="nest_list", tb_name="nest_list"),
  list(csv_file_name="join_table_parenthood"),
  list(csv_file_name="join_table_year_nests")
)
# Loop through the array and source the script for each content name
for (tmp_table in tables) {
  csv_file_name <- tmp_table$csv_file_name
  if (!is.null(tmp_table[["tb_name"]]) && length(tmp_table[["tb_name"]]) > 0) {
    table_name <- tmp_table[["tb_name"]]
  } else {
    table_name <- tmp_table[["csv_file_name"]]
  }
  cat("Processing: read", csv_file_name, ".csv to table", table_name ,"\n")  # Optional: Print progress
  source("src/db_loaddata_from_csv.R")
}

#### do SQL enhancements ####
source("src/db_manual_stuff_like_unique_index_foreignkey.R")

#### do stuff from Patrick Scherler ####
source("src/examples_database_queries_db.R")

#### disconnect ####
dbDisconnect(con)
