#### Preamble ####
# Purpose: Downloads and saves the data from Canadian hansard
# Author: Inessa De Angelis
# Date: 23 September 2023
# Contact: Inessa.DeAngelis@mail.utoronto.ca
# License: MIT
# Data set: https://www.lipad.ca/data/
# Note: Reference https://www.parl.ca/LegisInfo/en/bill/42-1/c-65 to see when the Bill was debated in the House 
# & https://openparliament.ca/bills/42-1/C-65/?tab=mentions to see when the Bill was discussed in QP

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

# Bill C-65 mentioned in QP, February 5, 2018 # 
raw_feb_5 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/2/2018-2-5.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Canada Post")

# Bill C-65 mentioned in QP, February 7, 2018 # 
raw_feb_7 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/2/2018-2-7.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Canadian Armed Forces")

# Bill C-65 mentioned during Gov't orders, March 1, 2018 # 
raw_mar_1 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/3/2018-3-1.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(speakername == "Rodger Cuzner")

# Bill C-65 mentioned during QP, March 29, 2018 # 
raw_mar_29 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/3/2018-3-29.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(speakername == "Rodger Cuzner")

# Bill C-65 mentioned during QP, April 26, 2018 # 
raw_apr_26 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/4/2018-4-26.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Status of Women")

# Bill C-65 mentioned during QP, April 26, 2018 # 
raw_apr_30 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/4/2018-4-30.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Workplace Safety")

# Bill C-65 mentioned during QP, May 3, 2018 # 
raw_may_3 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/5/2018-5-3.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(subtopic == "Business of the House")

# Bill C-65 mentioned during SO31, May 9, 2018 # 
raw_may_9 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/5/2018-5-9.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(speakername == "Pam Damoff")

# Bill C-65 mentioned during QP, May 11, 2018 # 
raw_may_11 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/5/2018-5-11.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(speakername == "Rodger Cuzner")

# Bill C-65 mentioned during Adjournment Proceedings, May 23, 2018 # 
raw_may_23 <- read_delim_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/5/2018-5-23.csv")) |>
  select(speechdate,
         speakeroldname,
         maintopic,
         subtopic,
         speechtext,
         speakerparty,
         speakerriding,
         speakername) |>
  filter(grepl('Bill C-65', speechtext))

#### Save data sets ####
write_csv(x = raw_nov_7, file = "Inputs/Data/raw_nov_7.csv")

write_csv(x = raw_jan_29, file = "Inputs/Data/raw_jan_29.csv")

write_csv(x = raw_may_7, file = "Inputs/Data/raw_may_7.csv")

write_csv(x = raw_oct_16, file = "Inputs/Data/raw_oct_16.csv")

write_csv(x = raw_oct_17, file = "Inputs/Data/raw_oct_17.csv")

write_csv(x = raw_feb_5, file = "Inputs/Data/raw_feb_5.csv")

write_csv(x = raw_feb_7, file = "Inputs/Data/raw_feb_7.csv")

write_csv(x = raw_mar_1, file = "Inputs/Data/raw_mar_1.csv")

write_csv(x = raw_mar_29, file = "Inputs/Data/raw_mar_29.csv")

write_csv(x = raw_apr_26, file = "Inputs/Data/raw_apr_26.csv")

write_csv(x = raw_apr_30, file = "Inputs/Data/raw_apr_30.csv")

write_csv(x = raw_may_3, file = "Inputs/Data/raw_may_3.csv")

write_csv(x = raw_may_9, file = "Inputs/Data/raw_may_9.csv")

write_csv(x = raw_may_11, file = "Inputs/Data/raw_may_11.csv")

write_csv(x = raw_may_23, file = "Inputs/Data/raw_may_23.csv")