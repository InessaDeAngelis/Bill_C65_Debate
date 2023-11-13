#### Preamble ####
# Purpose: Cleans data from the Canadian Hansard
# Author: Inessa De Angelis
# Date: 12 November 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Cleaning ####
# Read in the raw data sets #
nov_7_raw <- read_csv("Inputs/Data/raw_nov_7.csv", col_names = TRUE)
