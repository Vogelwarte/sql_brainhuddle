# renv_manage.R

library(renv)

# Check the current renv status
status <- renv::status()

if (status$synchronized == FALSE) {
  message("Changes detected. Creating a new snapshot...")
  renv::snapshot()
Y} else {
  message("No changes detected. Restoring the environment...")
  renv::restore()
}
