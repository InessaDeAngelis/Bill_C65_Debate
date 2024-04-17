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
  mutate(speaker_gender = case_when( # Add column with speaker gender, referencing: https://www.ourcommons.ca/Members/en/search?parliament=42
    startsWith(speakername, "Patty") ~ "Woman",
    startsWith(speakername, "Pam") ~ "Woman",
    startsWith(speakername, "Cheryl") ~ "Woman",
    startsWith(speakername, "Carla") ~ "Woman",
    startsWith(speakername, "Karine") ~ "Woman",
    startsWith(speakername, "Anita") ~ "Woman",
    startsWith(speakername, "Tracey") ~ "Woman",
    startsWith(speakername, "Michelle") ~ "Woman",
    startsWith(speakername, "Sylvie") ~ "Woman",
    startsWith(speakername, "Linda") ~ "Woman",
    startsWith(speakername, "Kate") ~ "Woman",
    startsWith(speakername, "Hedy") ~ "Woman",
    startsWith(speakername, "Rachael") ~ "Woman",
    startsWith(speakername, "Karen") ~ "Woman",
    startsWith(speakername, "Sheila") ~ "Woman",
    startsWith(speakername, "Irene") ~ "Woman",
    startsWith(speakername, "Filomena") ~ "Woman",
    startsWith(speakername, "Anju") ~ "Woman",
    startsWith(speakername, "Anne") ~ "Woman",
    startsWith(speakername, "Mona") ~ "Woman",
    startsWith(speakername, "Elizabeth") ~ "Woman",
    startsWith(speakername, "Rachel") ~ "Woman",
    startsWith(speakername, "Cathay") ~ "Woman",
    startsWith(speakername, "Cathy") ~ "Woman",
    startsWith(speakername, "Candice") ~ "Woman",
    startsWith(speakername, "Julie") ~ "Woman",
    startsWith(speakername, "Sheri") ~ "Woman",
    startsWith(speakername, "Kelly") ~ "Woman",
    startsWith(speakername, "Bardish") ~ "Woman",
    startsWith(speakername, "Emmanuella") ~ "Woman",
    startsWith(speakername, "Lisa") ~ "Woman",
    startsWith(speakername, "Eva") ~ "Woman",
    startsWith(speakername, "Rosemarie") ~ "Woman",
    startsWith(speakername, "Celina") ~ "Woman",
    startsWith(speakername, "Judy") ~ "Woman",
    startsWith(speakername, "Marilyn") ~ "Woman",
    startsWith(speakername, "Kevin") ~ "Man", # go on to male MPs
    startsWith(speakername, "John") ~ "Man",
    startsWith(speakername, "Mark") ~ "Man",
    startsWith(speakername, "TJ") ~ "Man",
    startsWith(speakername, "Pat") ~ "Man",
    startsWith(speakername, "Harjit") ~ "Man",
    startsWith(speakername, "Steven") ~ "Man",
    startsWith(speakername, "Arnold") ~ "Man",
    startsWith(speakername, "Garnett") ~ "Man",
    startsWith(speakername, "Pierre") ~ "Man",
    startsWith(speakername, "Sean") ~ "Man",
    startsWith(speakername, "Randy") ~ "Man",
    startsWith(speakername, "Ted") ~ "Man",
    startsWith(speakername, "Jim") ~ "Man",
    startsWith(speakername, "Nick") ~ "Man",
    startsWith(speakername, "Joël") ~ "Man",
    startsWith(speakername, "Ken") ~ "Man",
    startsWith(speakername, "Gérard") ~ "Man",
    startsWith(speakername, "Fayçal") ~ "Man",
    startsWith(speakername, "Todd") ~ "Man",
    startsWith(speakername, "Terry") ~ "Man",
    startsWith(speakername, "Bryan") ~ "Man",
    startsWith(speakername, "Alupa") ~ "Man",
    startsWith(speakername, "Rodger") ~ "Man",
    startsWith(speakername, "Lloyd") ~ "Man",
    startsWith(speakername, "Jati") ~ "Man",
    startsWith(speakername, "Richard") ~ "Man",
    startsWith(speakername, "Angelo") ~ "Man",
    startsWith(speakername, "Harold") ~ "Man",
    startsWith(speakername, "Robert") ~ "Man",
    startsWith(speakername, "Ed") ~ "Man",
    startsWith(speakername, "Gord") ~ "Man",
    startsWith(speakername, "François") ~ "Man",
    startsWith(speakername, "Rémi") ~ "Man",
    startsWith(speakername, "Tom") ~ "Man",
  )) |>
  select(speechdate, speechtext, speakerparty, speakerriding, speakername, speaker_gender)
cleaned_hansard_data

## Rename columns ##
cleaned_hansard_data =
  cleaned_hansard_data |>
  rename(
    speech_date = speechdate,
    text = speechtext,
    speaker_party = speakerparty,
    speaker_riding = speakerriding,
    speaker_name = speakername
  ) |>
select(speech_date, text, speaker_party, speaker_riding, speaker_name, speaker_gender)
cleaned_hansard_data

## Create dataset with only Liberals ##
LPC_cleaned_data =
  cleaned_hansard_data |>
  filter(speaker_party == "Liberal")
LPC_cleaned_data

## Create dataset with only Conservatives ##
CPC_cleaned_data =
  cleaned_hansard_data |>
  filter(speaker_party == "Conservative")
CPC_cleaned_data

## Create dataset with only New Democrats ##
NDP_cleaned_data =
  cleaned_hansard_data |>
  filter(speaker_party == "New Democratic Party")
NDP_cleaned_data

## Create dataset with only Greens ##
# Creating for now, but not enough interventions to model
GPC_cleaned_data =
  cleaned_hansard_data |>
  filter(speaker_party == "Green Party")
GPC_cleaned_data

## Create dataset of just women MPs ##
women_mps_data =
  cleaned_hansard_data |>
  filter(speaker_gender == "Woman")
women_mps_data

## Create dataset of just men MPs ##
men_mps_data =
  cleaned_hansard_data |>
  filter(speaker_gender == "Man")
men_mps_data

#### Save datasets ####
write_csv(x = cleaned_hansard_data, file = "Outputs/Data/cleaned_hansard_data.csv")

write_csv(x = LPC_cleaned_data, file = "Outputs/Data/LPC_cleaned_data.csv")

write_csv(x = CPC_cleaned_data, file = "Outputs/Data/CPC_cleaned_data.csv")

write_csv(x = NDP_cleaned_data, file = "Outputs/Data/NDP_cleaned_data.csv")

write_csv(x = GPC_cleaned_data, file = "Outputs/Data/GPC_cleaned_data.csv")

write_csv(x = women_mps_data, file = "Outputs/Data/women_mps_cleaned_data.csv")

write_csv(x = men_mps_data, file = "Outputs/Data/men_mps_cleaned_data.csv")