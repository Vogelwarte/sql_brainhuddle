#### db load data from CSV file ####
#### Stefan Hofstetter, November 10th, 2024 ####



# Construct the file path
csv_file <- glue("{data_path}/{csv_file_name}.csv")

# Read the first line to detect the delimiter
first_line <- readLines(csv_file, n = 1)

# Check if the first line contains ';' or ','
if (grepl(";", first_line)) {
  cat("Detected delimiter: ;\n")
  csv_data <- read_delim(csv_file, delim = ";")
} else if (grepl(",", first_line)) {
  cat("Detected delimiter: ,\n")
  csv_data <- read_csv(csv_file)  # Default `read_csv()` uses ','
} else {
  stop("Delimiter not recognized. Please check the file format.")
}

# Execute the CREATE TABLE query
# dbExecute(con, create_table_query)

# Write CSV data to PostgreSQL table
# dbWriteTable(con, content_name, csv_data, overwrite = TRUE, row.names = FALSE, )
dbWriteTable(con, table_name, append = TRUE, csv_data, row.names = FALSE, )


# db_copy_to(con, "individual_life_history", csv_data, overwrite = TRUE)

# Step 3: Verify data insertion
result <- dbGetQuery(con, glue("SELECT * FROM {table_name};"))

print(result)


