
# Step 1: Insert a single row into the table
insert_query <- "
INSERT INTO participants (name, position, salary)
VALUES ('John Doe', 'Developer', 75000);
"
dbExecute(con, insert_query)
message("Single row inserted successfully.")

# Step 2: Insert multiple rows using a data frame
data_to_insert <- data.frame(
  name = c("Alice Smith", "Bob Johnson", "Carol White"),
  position = c("Manager", "Analyst", "Intern"),
  salary = c(90000, 60000, 30000)
)


# add index
# Add a unique index on the 'name' field
#### 
# unique_index_query <- "CREATE UNIQUE INDEX IF NOT EXISTS unique_name_index ON participants (name);"
# dbExecute(con, unique_index_query)
# message("Unique index on 'name' field added successfully.")
####


# Use dbWriteTable for bulk inserts
dbWriteTable(con, "participants", data_to_insert, append = TRUE, row.names = FALSE)
message("Multiple rows inserted successfully.")

# Step 3: Verify data insertion
result <- dbGetQuery(con, "SELECT * FROM participants;")
print(result)
