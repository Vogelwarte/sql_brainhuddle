#### find unique and foreign fields #### 
ddl_sql_postgres <- c(
  "ALTER TABLE individual_life_history ALTER COLUMN \"bird_id\" TYPE int USING \"bird_id\"::int;",
  # "ALTER TABLE nest_list RENAME COLUMN \"ID\" TO nest_id;",
  "ALTER TABLE nest_list ALTER COLUMN \"ID\" TYPE int USING \"ID\"::int;",
  "SET datestyle = 'European, DMY';",
  "ALTER TABLE individual_life_history ALTER COLUMN hatching_date TYPE date USING hatching_date::date;",
  "CREATE UNIQUE INDEX individual_life_history_bird_id_idx ON individual_life_history (bird_id);",
  'CREATE UNIQUE INDEX nest_list_id_idx ON nest_list ("ID");',
#  'CREATE UNIQUE INDEX brood_parameters_id_idx ON brood_parameters ("year_id");',
  "ALTER TABLE join_table_parenthood ALTER COLUMN \"bird_id\" TYPE int USING \"bird_id\"::int;",
  "ALTER TABLE join_table_parenthood ALTER COLUMN \"father\" TYPE int USING \"father\"::int;",
  "ALTER TABLE join_table_parenthood ALTER COLUMN \"mother\" TYPE int USING \"mother\"::int;",
  "ALTER TABLE join_table_parenthood
ADD CONSTRAINT fk_bird_id_main
FOREIGN KEY (bird_id) REFERENCES individual_life_history(bird_id) on delete cascade;",
  "ALTER TABLE join_table_parenthood
ADD CONSTRAINT fk_father_id
FOREIGN KEY (father) REFERENCES individual_life_history(bird_id) on delete cascade;",
  "ALTER TABLE join_table_parenthood
ADD CONSTRAINT fk_mother_id
FOREIGN KEY (mother) REFERENCES individual_life_history(bird_id) on delete cascade;",
  "INSERT INTO nest_list (\"ID\", nest_name) VALUES (0, 'Unkown');",
  "UPDATE join_table_year_nests
SET nest_id = 0
WHERE nest_id = 'unknown';",
  "ALTER TABLE join_table_year_nests ALTER COLUMN \"bird_id\" TYPE int USING \"bird_id\"::int;",
  "ALTER TABLE join_table_year_nests ALTER COLUMN \"year\" TYPE int USING \"year\"::int;",
  "CREATE UNIQUE INDEX join_table_year_nests_year_idx ON join_table_year_nests (\"year\",bird_id);",
  "ALTER TABLE join_table_year_nests ALTER COLUMN \"nest_id\" TYPE int USING \"nest_id\"::int;",
  "ALTER TABLE join_table_year_nests
ADD CONSTRAINT fk_bird_id_main
FOREIGN KEY (bird_id) REFERENCES individual_life_history(bird_id) on delete cascade;",
  "ALTER TABLE join_table_year_nests
  ADD CONSTRAINT fk_nest_id_main
  FOREIGN KEY (nest_id) REFERENCES nest_list(\"ID\") on delete cascade;"
)


for (sql in ddl_sql_postgres) {
  cat("Processing:", sql, "\n")  # Optional: Print progress
  tryCatch({
    dbExecute(con, sql)
  },error = function(e) {
    # Handle errors and go to the next iteration of the loop
    cat("An error occurred while executing:", e$message, "\n")
    })
}


