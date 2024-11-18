# Step 3: Verify data insertion
result <- dbGetQuery(con, "SELECT * FROM participants;")
print(result)
