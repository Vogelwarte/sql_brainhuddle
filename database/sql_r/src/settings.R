
# Configure env and Packages


# Install necessary packages if not already installed
if (!require("renv")) install.packages("renv")
if (!require("RPostgres")) install.packages("RPostgres" )
if (!require("DBI")) install.packages("DBI")
if (!require("readr")) install.packages("readr")
if (!require("dbplyr")) install.packages("dbplyr")
if (!require("readxl")) install.packages("readxl")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("glue")) install.packages("glue")
# if (!require("RSQLite")) install.packages("RSQLite")

# Load necessary libraries
library(DBI)
library(RPostgres)
# library(RSQLite)
library(readr)
library(dplyr, warn.conflicts = FALSE)
library(glue)

