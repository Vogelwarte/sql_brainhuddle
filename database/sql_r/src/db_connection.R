# R/db_connection.R
# Database connection logic

connect_to_db <- function(actual_dbname="") {
  # Establish the database connection
  if (!actual_dbname == '')
  {
    actual_dbname = Sys.getenv("DATABASE_NAME")
  }  
  con <- dbConnect(
    RPostgres::Postgres(),
    
    dbname = actual_dbname,
    host = Sys.getenv("DATABASE_HOST"),
    port = as.integer(Sys.getenv("DATABASE_PORT")),
    user = Sys.getenv("DATABASE_USER"),
    password = Sys.getenv("DATABASE_PASSWORD")
  )
  
  return(con)
}

con <- connect_to_db("sql_brainhuddle")
#con <- connect_to_db()
if (dbIsValid(con)) {
  print("Database connection established successfully.")
}
