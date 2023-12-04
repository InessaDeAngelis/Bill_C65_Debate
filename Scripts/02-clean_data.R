#### Preamble ####
# Purpose: Cleans data from the Canadian Hansard
# Author: Inessa De Angelis
# Date: 3 December 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(readr)
library(dplyr)

#### Read in the raw data sets ####
# Code referenced from: https://community.rstudio.com/t/how-to-import-multiple-csv-files/119449/2
list_of_files <- list.files(path = "Inputs/Data",
                            recursive = TRUE,
                            pattern = "\\.csv$",
                            full.names = TRUE)

raw_hansard_data <- readr::read_csv(list_of_files, id = "file_name")

#### Cleaning ####
## Filter out interventions from the Speaker, Deputy Speaker, and Assistant Deputy Speakers ##
# Code to filter out speakers from: https://stackoverflow.com/questions/34905481/is-there-a-more-efficient-way-of-using-dplyr-filter-to-remove-rows-from-a-datafr
# Code to add "speaker gender" column from: https://www.marsja.se/r-add-column-to-dataframe-based-on-other-columns-conditions-dplyr/
cleaned_hansard_data =
  raw_hansard_data |>
  filter(!(
      speakeroldname == "The Deputy Speaker" |
      speakeroldname == "The Assistant Deputy Speaker (Mrs. Carol Hughes)" |
      speakeroldname == "The Assistant Deputy Speaker (Mr. Anthony Rota)" |
      speakeroldname == "The Speaker")
  ) |>
  mutate(speakergender = case_when( # Add column with speaker gender, referencing: https://www.ourcommons.ca/Members/en/search?parliament=42
    startsWith(speakername, "Patty") ~ "Female",
    startsWith(speakername, "Pam") ~ "Female",
    startsWith(speakername, "Cheryl") ~ "Female",
    startsWith(speakername, "Carla") ~ "Female",
    startsWith(speakername, "Karine") ~ "Female",
    startsWith(speakername, "Anita") ~ "Female",
    startsWith(speakername, "Tracey") ~ "Female",
    startsWith(speakername, "Michelle") ~ "Female",
    startsWith(speakername, "Sylvie") ~ "Female",
    startsWith(speakername, "Linda") ~ "Female",
    startsWith(speakername, "Kate") ~ "Female",
    startsWith(speakername, "Hedy") ~ "Female",
    startsWith(speakername, "Rachael") ~ "Female",
    startsWith(speakername, "Karen") ~ "Female",
    startsWith(speakername, "Sheila") ~ "Female",
    startsWith(speakername, "Irene") ~ "Female",
    startsWith(speakername, "Filomena") ~ "Female",
    startsWith(speakername, "Anju") ~ "Female",
    startsWith(speakername, "Anne") ~ "Female",
    startsWith(speakername, "Mona") ~ "Female",
    startsWith(speakername, "Elizabeth") ~ "Female",
    startsWith(speakername, "Rachel") ~ "Female",
    startsWith(speakername, "Cathay") ~ "Female",
    startsWith(speakername, "Cathy") ~ "Female",
    startsWith(speakername, "Candice") ~ "Female",
    startsWith(speakername, "Julie") ~ "Female",
    startsWith(speakername, "Sheri") ~ "Female",
    startsWith(speakername, "Kelly") ~ "Female",
    startsWith(speakername, "Bardish") ~ "Female",
    startsWith(speakername, "Emmanuella") ~ "Female",
    startsWith(speakername, "Lisa") ~ "Female",
    startsWith(speakername, "Eva") ~ "Female",
    startsWith(speakername, "Rosemarie") ~ "Female",
    startsWith(speakername, "Celina") ~ "Female",
    startsWith(speakername, "Judy") ~ "Female",
    startsWith(speakername, "Marilyn") ~ "Female",
    startsWith(speakername, "Kevin") ~ "Male", # go on to male MPs
    startsWith(speakername, "John") ~ "Male",
    startsWith(speakername, "Mark") ~ "Male",
    startsWith(speakername, "TJ") ~ "Male",
    startsWith(speakername, "Pat") ~ "Male",
    startsWith(speakername, "Harjit") ~ "Male",
    startsWith(speakername, "Steven") ~ "Male",
    startsWith(speakername, "Arnold") ~ "Male",
    startsWith(speakername, "Garnett") ~ "Male",
    startsWith(speakername, "Pierre") ~ "Male",
    startsWith(speakername, "Sean") ~ "Male",
    startsWith(speakername, "Randy") ~ "Male",
    startsWith(speakername, "Ted") ~ "Male",
    startsWith(speakername, "Jim") ~ "Male",
    startsWith(speakername, "Nick") ~ "Male",
    startsWith(speakername, "Joël") ~ "Male",
    startsWith(speakername, "Ken") ~ "Male",
    startsWith(speakername, "Gérard") ~ "Male",
    startsWith(speakername, "Fayçal") ~ "Male",
    startsWith(speakername, "Todd") ~ "Male",
    startsWith(speakername, "Terry") ~ "Male",
    startsWith(speakername, "Bryan") ~ "Male",
    startsWith(speakername, "Alupa") ~ "Male",
    startsWith(speakername, "Rodger") ~ "Male",
    startsWith(speakername, "Lloyd") ~ "Male",
    startsWith(speakername, "Jati") ~ "Male",
    startsWith(speakername, "Richard") ~ "Male",
    startsWith(speakername, "Angelo") ~ "Male",
    startsWith(speakername, "Harold") ~ "Male",
    startsWith(speakername, "Robert") ~ "Male",
    startsWith(speakername, "Ed") ~ "Male",
    startsWith(speakername, "Gord") ~ "Male",
    startsWith(speakername, "François") ~ "Male",
    startsWith(speakername, "Rémi") ~ "Male",
    startsWith(speakername, "Tom") ~ "Male",
  )) |>
  select(speechdate, speechtext, speakerparty, speakerriding, speakername, speakergender)
cleaned_hansard_data

## Create dataset with only Liberals ##
LPC_cleaned_data =
  cleaned_hansard_data |>
  filter(speakerparty == "Liberal")
LPC_cleaned_data

## Create dataset with only Conservatives ##
CPC_cleaned_data =
  cleaned_hansard_data |>
  filter(speakerparty == "Conservative")
CPC_cleaned_data

## Create dataset with only New Democrats ##
NDP_cleaned_data =
  cleaned_hansard_data |>
  filter(speakerparty == "New Democratic Party")
NDP_cleaned_data

## Create dataset with only Greens ##
# Creating for now, but not enough interventions to model
GPC_cleaned_data =
  cleaned_hansard_data |>
  filter(speakerparty == "Green Party")
GPC_cleaned_data

#### Save datasets ####
write_csv(x = cleaned_hansard_data, file = "Outputs/Data/cleaned_hansard_data.csv")

write_csv(x = LPC_cleaned_data, file = "Outputs/Data/LPC_cleaned_data.csv")

write_csv(x = CPC_cleaned_data, file = "Outputs/Data/CPC_cleaned_data.csv")

write_csv(x = NDP_cleaned_data, file = "Outputs/Data/NDP_cleaned_data.csv")

write_csv(x = GPC_cleaned_data, file = "Outputs/Data/GPC_cleaned_data.csv")