# Step: Create a new table
create_table_query <- "
CREATE TABLE IF NOT EXISTS participants (
  id SERIAL PRIMARY KEY,
  tm_created timestamptz DEFAULT now() NOT NULL;
  name TEXT NOT NULL,
  position TEXT NOT NULL,
  salary NUMERIC
);"

dbExecute(con, create_table_query)
message("Table created successfully.")

# Step: List all tables in the database
tables <- dbListTables(con)
message("Tables in the database: ", paste(tables, collapse = ", "))
