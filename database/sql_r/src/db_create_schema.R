# Step: Create a new schema

tryCatch({
  dbExecute(con,  glue("CREATE SCHEMA {schema_name};"))
  message("Schema created successfully.")
    },error = function(e) {
  cat("schema with that name exists already:", e$message, "\n")
})

dbExecute(con, glue("SET search_path TO {schema_name};"))
message(glue("Set {schema_name} to default."))

        