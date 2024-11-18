# Load libraries and helper functions
source("src/renv_manage.R")
source("src/settings.R")
#### Read environ (if not in env - is stored in $home) ####
readRenviron(".Renviron.redkite")
### for local use with SQLite
#source("src/db_connection_local.R")
source("src/db_connection.R")

# Connect and print connection status for testing
db_name <- "rotmilan"
# source("src/db_create_db.R")
# Define the path where the data is stored

data_path <- "../../rotmilan"
# Define an array of content names
tables <- list(
  list(csv_file_name="individual_life_history"),
  list(csv_file_name="brood_parameters"),
  list(csv_file_name="nest_list_corrected", tb_name="nest_list"),
  list(csv_file_name="join_table_parenthood"),
  list(csv_file_name="join_table_year_nests")
)
# Loop through the array and source the script for each content name
for (tmp_table in tables) {
  print(class(tmp_table))
  print(tmp_table)
  print(tmp_table[["csv_file_name"]])
  csv_file_name <- tmp_table$csv_file_name
  if (!is.null(tmp_table[["tb_name"]]) && length(tmp_table[["tb_name"]]) > 0) {
    table_name <- tmp_table[["tb_name"]]
  } else {
    table_name <- tmp_table[["csv_file_name"]]
  }
  cat("Processing: read", csv_file_name, ".csv to table", table_name ,"\n")  # Optional: Print progress
  source("src/db_loaddata_from_csv.R")
}

### disconnect
dbDisconnect(con)
