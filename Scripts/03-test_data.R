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

# Read in the Female MPs data #
female_mps_data <- read_csv("Outputs/Data/female_mps_cleaned_data.csv")
show_col_types = FALSE

# Read in the Male MPs data #
female_mps_data <- read_csv("Outputs/Data/male_mps_cleaned_data.csv")
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

#### Testing - LPC dataset ####
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
  confront(LPC_cleaned_data, rules)

summary(out)

# Check number of rows is correct #
nrow(LPC_cleaned_data) == 176

#### Testing - CPC dataset ####
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
  confront(CPC_cleaned_data, rules)

summary(out)

# Check number of rows is correct #
nrow(CPC_cleaned_data) == 144

#### Testing - NDP dataset ####
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
  confront(NDP_cleaned_data, rules)

summary(out)

# Check number of rows is correct #
nrow(NDP_cleaned_data) == 81

#### Testing - GPC dataset ####
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
  confront(GPC_cleaned_data, rules)

summary(out)

# Check number of rows is correct #
nrow(GPC_cleaned_data) == 2

#### Testing - Female MPs dataset ####
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
  confront(female_mps_data, rules)

summary(out)

# Check number of rows is correct #
nrow(female_mps_data) == 196

#### Testing - Male MPs dataset ####
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
  confront(male_mps_data, rules)

summary(out)

# Check number of rows is correct #
# (so a side note, it's intesting that there were the same number of interventions from male and female MPs)
nrow(male_mps_data) == 196 
