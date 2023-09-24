#### Preamble ####
# Purpose: Downloads and saves the data from Canadian hansard
# Author: Inessa De Angelis
# Date: 23 September 2023
# Contact: Inessa.DeAngelis@mail.utoronto.ca
# License: MIT
# Data set: https://www.lipad.ca/data/
# Note: Reference https://www.parl.ca/LegisInfo/en/bill/42-1/c-65 to see which days/years/months the Bill was debated in the House 

#### Workspace setup ####
library(tidyverse)
library(archive)
library(readr)
library(arrow)

#### Download data ####
# Code referenced from: https://stackoverflow.com/questions/7151145/unzip-a-tar-gz-file & https://www.youtube.com/watch?v=LKprlFCLnSA&ab_channel=RiffomonasProject
options(timeout = 400)
hansard_data <- "https://www.lipad.ca/media/lipadcsv-1.1.0.tar.bz2"
download.file(hansard_data, destfile = "lipadcsv-1.1.0.tar.bz2")

# Select individual files of interest, select relevant columns, and filter by subtopic # 
# Code referenced from: https://arrow.apache.org/docs/r/reference/read_delim_arrow.html

archive("lipadcsv-1.1.0.tar.bz2")

# Bill C-65 First Reading, November 7, 2017 # 
raw_nov_7 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2017/11/2017-11-7.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Canada Labour Code")

# Bill C-65 Second Reading, January 29, 2018 #  
raw_jan_29 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/1/2018-1-29.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Canada Labour Code")

# Bill C-65 End of Report Stage & Third Reading, May 7, 2018 #  
raw_may_7 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/5/2018-5-7.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Canada Labour Code")

# Bill C-65 Consideration of Senate amendments, Oct 16, 2018 #  
raw_oct_16 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/10/2018-10-16.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Canada Labour Code")

# Bill C-65 Consideration of Senate amendments, Oct 17, 2018 #  
raw_oct_17 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/10/2018-10-17.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Canada Labour Code")

#### Save data sets ####
write_csv(x = raw_nov_7, file = "Inputs/Data/raw_nov_7.csv")

write_csv(x = raw_jan_29, file = "Inputs/Data/raw_jan_29.csv")

write_csv(x = raw_may_7, file = "Inputs/Data/raw_may_7.csv")

write_csv(x = raw_oct_16, file = "Inputs/Data/raw_oct_16.csv")

write_csv(x = raw_oct_17, file = "Inputs/Data/raw_oct_17.csv")