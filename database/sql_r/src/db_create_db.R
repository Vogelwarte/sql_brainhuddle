# Step 1: Create a new database (requires appropriate permissions)
create_db_query <- paste0("CREATE DATABASE ", db_name, ";")
tryCatch({
  dbExecute(con, create_db_query)
  message("Database created successfully.")
}, error = function(e) {
  message("Error creating database: ", e$message)
})

