#### Preamble ####
# Purpose: Downloads and saves the data from Canadian hansard
# Author: Inessa De Angelis
# Date: 23 September 2023
# Contact: Inessa.DeAngelis@mail.utoronto.ca
# License: MIT
# Data set: https://www.lipad.ca/data/
# Note: Reference https://www.parl.ca/LegisInfo/en/bill/42-1/c-65 to see which days/years/months the Bill was debated in the House and at committee

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

# View and selected individual files of interest # 
# Code referenced from: https://arrow.apache.org/docs/r/reference/read_delim_arrow.html

archive("lipadcsv-1.1.0.tar.bz2")

read_tsv_arrow(archive_read("lipadcsv-1.1.0.tar.bz2", "lipad/2018/1/2018-1-29.csv"))
