#### Preamble ####
# Purpose: Tests the cleaned data
# Author: Inessa De Angelis
# Date: 4 December 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # 01-download_data.R
  # 02-clean_data.R

#### Workspace setup ####
library(validate)
library(tidyverse)

#### Read in datasets ####
# Read in the main cleaned hansard data # 
cleaned_hansard_data <- read_csv("Outputs/Data/cleaned_hansard_data.csv")
show_col_types = FALSE

# Read in the LPC data #
LPC_cleaned_data <- read_csv("Outputs/Data/LPC_cleaned_data.csv")
show_col_types = FALSE

# Read in the CPC data #
CPC_cleaned_data <- read_csv("Outputs/Data/CPC_cleaned_data.csv")
show_col_types = FALSE

# Read in the NDP data #
NDP_cleaned_data <- read_csv("Outputs/Data/NDP_cleaned_data.csv")
show_col_types = FALSE

# Read in the GPC data #
GPC_cleaned_data <- read_csv("Outputs/Data/GPC_cleaned_data.csv")
show_col_types = FALSE

#### Testing - Main dataset ####
rules <- validator(
  is.Date(speechdate),
  is.character(speechtext),
  is.character(speakerparty),
  is.character(speakerriding),
  is.character(speakername),
  is.character(speakergender),
  speakergender %vin% c("Female", "Male") # Check to make sure the only options for 'gender' are male or female
)

out <-
  confront(cleaned_hansard_data, rules)

summary(out)

# Check number of rows is correct #
nrow(cleaned_hansard_data) == 403

