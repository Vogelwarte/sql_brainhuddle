# R/db_connection.R
# Database connection logic

connect_to_db <- function(actual_dbname="") {
  # Establish the database connection
  if (!actual_dbname == '')
  {
    actual_dbname = Sys.getenv("DATABASE_NAME")
  }  
  con <- dbConnect(
    RSQLite::SQLite(), "local_db.sqlite"
  )
  
  return(con)
}

con <- connect_to_db("sql_brainhuddle")
#con <- connect_to_db()
if (dbIsValid(con)) {
  print("Database connection established successfully.")
}
