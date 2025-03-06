#############################################################################
#### Türk Dış Yardımlarında Balkanlar ve Balkan Türkleri
#### TIKA, TDV, YTB, YEE Yıllık Raporların Çekilmesi ve Veri Seti
#### 4-5 Şubat 2025
#############################################################################

setwd("/Users/emiryazici/Desktop/Raporlar")


# Load necessary libraries
library(rvest)
library(httr)

#############
#############Download TIKA Reports
#############
# Define the URL of the webpage containing PDFs
webpage_url <- "https://tika.gov.tr/basin-odasi/yayinlar/tika-faaliyet-raporlari/page/2/"  # Change this to your target URL

# Read the HTML content of the webpage
page <- read_html(webpage_url)

# Extract all PDF links
pdf_links <- page %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  na.omit() %>%
  grep("\\.pdf$", ., value = TRUE)

# Make sure links are absolute URLs
pdf_links <- ifelse(grepl("^http", pdf_links), pdf_links, paste0(webpage_url, pdf_links))

# Create a folder to save PDFs
dir.create("TikaRaporları", showWarnings = FALSE)

# Download each PDF
for (pdf_url in pdf_links) {
  pdf_name <- paste0("TikaRaporları/", basename(pdf_url))
  tryCatch({
    download.file(pdf_url, pdf_name, mode = "wb")
    message(paste("Downloaded:", pdf_name))
  }, error = function(e) {
    message(paste("Failed to download:", pdf_url))
  })
}

message("Download process completed!")



################################################################################
#############Download TIKA Kalkınma Reports
################################################################################
# Define the URL of the webpage containing PDFs
webpage_url <- "https://tika.gov.tr/basin-odasi/yayinlar/turkiye-kalkinma-yardimlari-raporlari/"  # Change this to your target URL

# Read the HTML content of the webpage
page <- read_html(webpage_url)

# Extract all PDF links
pdf_links <- page %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  na.omit() %>%
  grep("\\.pdf$", ., value = TRUE)

# Make sure links are absolute URLs
pdf_links <- ifelse(grepl("^http", pdf_links), pdf_links, paste0(webpage_url, pdf_links))

# Create a folder to save PDFs
dir.create("TikaRaporları2", showWarnings = FALSE)

# Download each PDF
for (pdf_url in pdf_links) {
  pdf_name <- paste0("TikaRaporları2", basename(pdf_url))
  tryCatch({
    download.file(pdf_url, pdf_name, mode = "wb")
    message(paste("Downloaded:", pdf_name))
  }, error = function(e) {
    message(paste("Failed to download:", pdf_url))
  })
}

message("Download process completed!")

  
################################################################################
#############Download YEE Reports
################################################################################
# Load necessary libraries
library(httr)

# Base URL format
base_url <- "https://www.yee.org.tr/tr/yayin/"

# Define the range of years
years <- 2014:2023

# Create a folder to save PDFs
dir.create("YeeRaporları", showWarnings = FALSE)

# Loop through each year and construct the URL
for (year in years) {
  # Construct the full URL for each year
  pdf_page_url <- paste0(base_url, year, "-faaliyet-raporu")
  
  # Define the PDF file name
  pdf_file_name <- paste0("YeeRaporları/", year, "-faaliyet-raporu.pdf")
  
  # Try downloading the PDF
  tryCatch({
    download.file(pdf_page_url, pdf_file_name, mode = "wb")
    message(paste("Downloaded:", pdf_file_name))
  }, error = function(e) {
    message(paste("Failed to download:", pdf_page_url))
  })
}

message("Download process completed!")

################################################################################
#############Download TDV Reports
################################################################################
# Define the URL of the webpage containing PDFs
webpage_url <- "https://tdv.org/tr-TR/medya-odasi/raporlar/"  # Change this to your target URL

# Read the HTML content of the webpage
page <- read_html(webpage_url)

# Extract all PDF links
pdf_links <- page %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  na.omit() %>%
  grep("\\.pdf$", ., value = TRUE)

# Make sure links are absolute URLs
pdf_links <- ifelse(grepl("^http", pdf_links), pdf_links, paste0(webpage_url, pdf_links))

# Create a folder to save PDFs
dir.create("TDVRaporları", showWarnings = FALSE)

# Download each PDF
for (pdf_url in pdf_links) {
  pdf_name <- paste0("TDVRaporları/", basename(pdf_url))
  tryCatch({
    download.file(pdf_url, pdf_name, mode = "wb")
    message(paste("Downloaded:", pdf_name))
  }, error = function(e) {
    message(paste("Failed to download:", pdf_url))
  })
}

message("Download process completed!")


################################################################################
#############Download YTB Reports
################################################################################
# Load necessary library
library(httr)

# Base URL format
base_url <- "https://ytbweb1.blob.core.windows.net/files/resimler/activity_reports/"

# Define the range of years
years <- 2010:2023

# Create a folder to save PDFs
dir.create("YtbRaporları", showWarnings = FALSE)

# Loop through each year and construct the URL
for (year in years) {
  # Construct the full URL for each year
  pdf_url <- paste0(base_url, year, "-faaliyet-raporu.pdf")
  
  # Define the PDF file name
  pdf_file_name <- paste0("YtbRaporları/", year, "-faaliyet-raporu.pdf")
  
  # Try downloading the PDF
  tryCatch({
    download.file(pdf_url, pdf_file_name, mode = "wb")
    message(paste("Downloaded:", pdf_file_name))
  }, error = function(e) {
    message(paste("Failed to download:", pdf_url))
  })
}

message("Download process completed!")

### YTB 2016-2020
# Load necessary library
library(httr)

# Base URL format
base_url <- "https://ytbweb1.blob.core.windows.net/files/resimler/activity_reports/"

# Define the range of years
years <- 2016:2020

# Create a folder to save PDFs
dir.create("YtbRaporları2", showWarnings = FALSE)

# Loop through each year and construct the URL
for (year in years) {
  # Construct the full URL for each year
  pdf_url <- paste0(base_url, year, "-idare-faaliyet-raporu.pdf")
  
  # Define the PDF file name
  pdf_file_name <- paste0("YtbRaporları2", year, "-idare-faaliyet-raporu.pdf")
  
  # Try downloading the PDF
  tryCatch({
    download.file(pdf_url, pdf_file_name, mode = "wb")
    message(paste("Downloaded:", pdf_file_name))
  }, error = function(e) {
    message(paste("Failed to download:", pdf_url))
  })
}

message("Download process completed!")



################################################################################
############# Raporlardan Veri Çekme/Kodlama
################################################################################
library(pdftools)
library(tidyverse)
library(stringr)
library(dplyr)
library(readr)
install.packages("openxlsx")
library(openxlsx)


################################################################################
############# Tika Raporları Kodlama
################################################################################
# Install necessary packages if not already installed
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) install.packages(pkg, dependencies = TRUE)
}

install_if_missing("pdftools")
install_if_missing("stringr")
install_if_missing("tidyverse")
install_if_missing("lubridate")

library(pdftools)
library(stringr)
library(tidyverse)
library(lubridate)  # For better date parsing

# Define the folder containing PDFs
tikaraporları <- "/Users/emiryazici/Desktop/Raporlar/TikaRaporları"  # Change this to your actual folder

# Define keywords to search for
keywords <- c("Bulgaristan", "Yunanistan", "Kosova", "Makedonya")  # Modify with your keywords

# Function to extract text, filter sentences, and create a structured dataset
extract_sentences_from_pdfs <- function(tikaraporları, keywords) {
  pdf_files <- list.files(tikaraporları, pattern = "\\.pdf$", full.names = TRUE)
  
  
  results <- data.frame(Document = character(), Date = character(), Sentence = character(), stringsAsFactors = FALSE)
  
  for (pdf in pdf_files) {
    # Extract text from PDF
    text <- pdf_text(pdf)
    
    # Flatten multiple pages into a single text
    full_text <- paste(text, collapse = " ")
    
    # Split into sentences
    sentences <- unlist(strsplit(full_text, "(?<=[.!?])\\s+", perl = TRUE))
    
    # Filter sentences containing any of the keywords (case-insensitive fix)
    matched_sentences <- sentences[str_detect(sentences, regex(str_c(keywords, collapse = "|"), ignore_case = TRUE))]
    
    # Extract document name and assumed date from the filename (modify regex if needed)
    doc_name <- basename(pdf)
    doc_date <- str_extract(doc_name, "\\d{4}-\\d{2}-\\d{2}")  # Assumes YYYY-MM-DD format in filename
    
    # Store results
    if (length(matched_sentences) > 0) {
      results <- bind_rows(results, data.frame(Document = doc_name, Date = doc_date, Sentence = matched_sentences, stringsAsFactors = FALSE))
    }
  }
  
  return(results)
}

# Run function and store results
dataset <- extract_sentences_from_pdfs(tikaraporları, keywords)
tikadata <- dataset

#Remove white spaces and create a new column called "clean_text" for them.
tikadata$clean_sentence <- gsub("\\s+", " ", tikadata$Sentence)

# Date does not show up in the dataset. Extract it from the document name.
library(stringr)
library(dplyr)

tikadata <- tikadata %>%
  mutate(Date = str_extract(Document, "\\d{4}"))  # Extracts 4-digit year

# View updated dataset
head(tikadata)

# Add Recipient Code and Name based on keywords in the Sentence column
library(dplyr)
library(tidyr)
library(stringr)

# Define recipient mapping
recipient_mapping <- tibble(
  keyword = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya"),
  code = c(347, 350, 355, 343),
  name = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya")
)

# Function to expand dataset with multiple recipient rows
tikadata <- tikadata %>%
  rowwise() %>%
  mutate(
    Recipient_Code = list(recipient_mapping$code[str_detect(Sentence, recipient_mapping$keyword)]),
    Recipient_Name = list(recipient_mapping$name[str_detect(Sentence, recipient_mapping$keyword)])
  ) %>%
  unnest(cols = c(Recipient_Code, Recipient_Name)) %>%
  ungroup()

# Add the name of the source (will be useful after the merge with other data)
tikadata <- tikadata %>%
  mutate(Source = "Tika")

# View updated dataset
head(dataset)

# Save dataset to CSV
write.csv(tikadata, "tikadata.csv", row.names = FALSE)


################################################################################
############# TDV Raporları Kodlama
################################################################################
# Install necessary packages if not already installed
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) install.packages(pkg, dependencies = TRUE)
}

install_if_missing("pdftools")
install_if_missing("stringr")
install_if_missing("tidyverse")
install_if_missing("lubridate")

library(pdftools)
library(stringr)
library(tidyverse)
library(lubridate)  # For better date parsing

# Define the folder containing PDFs
tdvraporları <- "/Users/emiryazici/Desktop/Raporlar/TDVRaporları"  # Change this to your actual folder

# Define keywords to search for
keywords <- c("Bulgaristan", "Yunanistan", "Kosova", "Makedonya")  # Modify with your keywords

# Function to extract text, filter sentences, and create a structured dataset
extract_sentences_from_pdfs <- function(tdvraporları, keywords) {
  pdf_files <- list.files(tdvraporları, pattern = "\\.pdf$", full.names = TRUE)
  
  
  results <- data.frame(Document = character(), Date = character(), Sentence = character(), stringsAsFactors = FALSE)
  
  for (pdf in pdf_files) {
    # Extract text from PDF
    text <- pdf_text(pdf)
    
    # Flatten multiple pages into a single text
    full_text <- paste(text, collapse = " ")
    
    # Split into sentences
    sentences <- unlist(strsplit(full_text, "(?<=[.!?])\\s+", perl = TRUE))
    
    # Filter sentences containing any of the keywords (case-insensitive fix)
    matched_sentences <- sentences[str_detect(sentences, regex(str_c(keywords, collapse = "|"), ignore_case = TRUE))]
    
    # Extract document name and assumed date from the filename (modify regex if needed)
    doc_name <- basename(pdf)
    doc_date <- str_extract(doc_name, "\\d{4}-\\d{2}-\\d{2}")  # Assumes YYYY-MM-DD format in filename
    
    # Store results
    if (length(matched_sentences) > 0) {
      results <- bind_rows(results, data.frame(Document = doc_name, Date = doc_date, Sentence = matched_sentences, stringsAsFactors = FALSE))
    }
  }
  
  return(results)
}

# Run function and store results
dataset <- extract_sentences_from_pdfs(tdvraporları, keywords)
tdvdata <- dataset

#Remove white spaces and create a new column called "clean_text" for them.
tdvdata$clean_sentence <- gsub("\\s+", " ", tdvdata$Sentence)

# Date does not show up in the dataset. Extract it from the document name.
library(stringr)
library(dplyr)

tdvdata <- tdvdata %>%
  mutate(Date = str_extract(Document, "\\d{4}"))  # Extracts 4-digit year

# View updated dataset
head(tdvdata)

# Add Recipient Code and Name based on keywords in the Sentence column
library(dplyr)
library(tidyr)
library(stringr)

# Define recipient mapping
recipient_mapping <- tibble(
  keyword = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya"),
  code = c(347, 350, 355, 343),
  name = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya")
)

# Function to expand dataset with multiple recipient rows
tdvdata <- tdvdata %>%
  rowwise() %>%
  mutate(
    Recipient_Code = list(recipient_mapping$code[str_detect(Sentence, recipient_mapping$keyword)]),
    Recipient_Name = list(recipient_mapping$name[str_detect(Sentence, recipient_mapping$keyword)])
  ) %>%
  unnest(cols = c(Recipient_Code, Recipient_Name)) %>%
  ungroup()

# Add the name of the source (will be useful after the merge with other data)
tdvdata <- tdvdata %>%
  mutate(Source = "TDV")

# View updated dataset
head(dataset)

# Save dataset to CSV
write.csv(tdvdata, "tdvdata.csv", row.names = FALSE)


setwd("/Users/emiryazici/Desktop/Raporlar")

################################################################################
############# YEE Raporları Kodlama
################################################################################
# Install necessary packages if not already installed
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) install.packages(pkg, dependencies = TRUE)
}

install_if_missing("pdftools")
install_if_missing("stringr")
install_if_missing("tidyverse")
install_if_missing("lubridate")

library(pdftools)
library(stringr)
library(tidyverse)
library(lubridate)  # For better date parsing

# Define the folder containing PDFs
yeeraporları <- "/Users/emiryazici/Desktop/Raporlar/YeeRaporları"  # Change this to your actual folder

# Define keywords to search for
keywords <- c("Bulgaristan", "Yunanistan", "Kosova", "Makedonya")  # Modify with your keywords

# Function to extract text, filter sentences, and create a structured dataset
extract_sentences_from_pdfs <- function(yeeraporları, keywords) {
  pdf_files <- list.files(yeeraporları, pattern = "\\.pdf$", full.names = TRUE)
  
  
  results <- data.frame(Document = character(), Date = character(), Sentence = character(), stringsAsFactors = FALSE)
  
  for (pdf in pdf_files) {
    # Extract text from PDF
    text <- pdf_text(pdf)
    
    # Flatten multiple pages into a single text
    full_text <- paste(text, collapse = " ")
    
    # Split into sentences
    sentences <- unlist(strsplit(full_text, "(?<=[.!?])\\s+", perl = TRUE))
    
    # Filter sentences containing any of the keywords (case-insensitive fix)
    matched_sentences <- sentences[str_detect(sentences, regex(str_c(keywords, collapse = "|"), ignore_case = TRUE))]
    
    # Extract document name and assumed date from the filename (modify regex if needed)
    doc_name <- basename(pdf)
    doc_date <- str_extract(doc_name, "\\d{4}-\\d{2}-\\d{2}")  # Assumes YYYY-MM-DD format in filename
    
    # Store results
    if (length(matched_sentences) > 0) {
      results <- bind_rows(results, data.frame(Document = doc_name, Date = doc_date, Sentence = matched_sentences, stringsAsFactors = FALSE))
    }
  }
  
  return(results)
}

# Run function and store results
dataset <- extract_sentences_from_pdfs(yeeraporları, keywords)
yeedata <- dataset

#Remove white spaces and create a new column called "clean_text" for them.
yeedata$clean_sentence <- gsub("\\s+", " ", yeedata$Sentence)

# Date does not show up in the dataset. Extract it from the document name.
library(stringr)
library(dplyr)

yeedata <- yeedata %>%
  mutate(Date = str_extract(Document, "\\d{4}"))  # Extracts 4-digit year

# View updated dataset
head(yeedata)

# Add Recipient Code and Name based on keywords in the Sentence column
library(dplyr)
library(tidyr)
library(stringr)

# Define recipient mapping
recipient_mapping <- tibble(
  keyword = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya"),
  code = c(347, 350, 355, 343),
  name = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya")
)

# Function to expand dataset with multiple recipient rows
yeedata <- yeedata %>%
  rowwise() %>%
  mutate(
    Recipient_Code = list(recipient_mapping$code[str_detect(Sentence, recipient_mapping$keyword)]),
    Recipient_Name = list(recipient_mapping$name[str_detect(Sentence, recipient_mapping$keyword)])
  ) %>%
  unnest(cols = c(Recipient_Code, Recipient_Name)) %>%
  ungroup()

# Add the name of the source (will be useful after the merge with other data)
yeedata <- yeedata %>%
  mutate(Source = "Yee")

# View updated dataset
head(yeedata)

# Save dataset to CSV
write.csv(yeedata, "yeedata.csv", row.names = FALSE)


################################################################################
############# YTB Raporları Kodlama
################################################################################
# Install necessary packages if not already installed
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) install.packages(pkg, dependencies = TRUE)
}

install_if_missing("pdftools")
install_if_missing("stringr")
install_if_missing("tidyverse")
install_if_missing("lubridate")

library(pdftools)
library(stringr)
library(tidyverse)
library(lubridate)  # For better date parsing

# Define the folder containing PDFs
ytbraporları <- "/Users/emiryazici/Desktop/Raporlar/YtbRaporları"  # Change this to your actual folder

# Define keywords to search for
keywords <- c("Bulgaristan", "Yunanistan", "Kosova", "Makedonya")  # Modify with your keywords

# Function to extract text, filter sentences, and create a structured dataset
extract_sentences_from_pdfs <- function(ytbraporları, keywords) {
  pdf_files <- list.files(ytbraporları, pattern = "\\.pdf$", full.names = TRUE)
  
  
  results <- data.frame(Document = character(), Date = character(), Sentence = character(), stringsAsFactors = FALSE)
  
  for (pdf in pdf_files) {
    # Extract text from PDF
    text <- pdf_text(pdf)
    
    # Flatten multiple pages into a single text
    full_text <- paste(text, collapse = " ")
    
    # Split into sentences
    sentences <- unlist(strsplit(full_text, "(?<=[.!?])\\s+", perl = TRUE))
    
    # Filter sentences containing any of the keywords (case-insensitive fix)
    matched_sentences <- sentences[str_detect(sentences, regex(str_c(keywords, collapse = "|"), ignore_case = TRUE))]
    
    # Extract document name and assumed date from the filename (modify regex if needed)
    doc_name <- basename(pdf)
    doc_date <- str_extract(doc_name, "\\d{4}-\\d{2}-\\d{2}")  # Assumes YYYY-MM-DD format in filename
    
    # Store results
    if (length(matched_sentences) > 0) {
      results <- bind_rows(results, data.frame(Document = doc_name, Date = doc_date, Sentence = matched_sentences, stringsAsFactors = FALSE))
    }
  }
  
  return(results)
}

# Run function and store results
dataset <- extract_sentences_from_pdfs(ytbraporları, keywords)
ytbdata <- dataset

#Remove white spaces and create a new column called "clean_text" for them.
ytbdata$clean_sentence <- gsub("\\s+", " ", ytbdata$Sentence)

# Date does not show up in the dataset. Extract it from the document name.
library(stringr)
library(dplyr)

ytbdata <- ytbdata %>%
  mutate(Date = str_extract(Document, "\\d{4}"))  # Extracts 4-digit year

# View updated dataset
head(ytbdata)

# Add Recipient Code and Name based on keywords in the Sentence column
library(dplyr)
library(tidyr)
library(stringr)

# Define recipient mapping
recipient_mapping <- tibble(
  keyword = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya"),
  code = c(347, 350, 355, 343),
  name = c("Kosova", "Yunanistan", "Bulgaristan", "Makedonya")
)

# Function to expand dataset with multiple recipient rows
ytbdata <- ytbdata %>%
  rowwise() %>%
  mutate(
    Recipient_Code = list(recipient_mapping$code[str_detect(Sentence, recipient_mapping$keyword)]),
    Recipient_Name = list(recipient_mapping$name[str_detect(Sentence, recipient_mapping$keyword)])
  ) %>%
  unnest(cols = c(Recipient_Code, Recipient_Name)) %>%
  ungroup()

# Add the name of the source (will be useful after the merge with other data)
ytbdata <- ytbdata %>%
  mutate(Source = "Yee")

# View updated dataset
head(ytbdata)

# Save dataset to CSV
write.csv(ytbdata, "ytbdata.csv", row.names = FALSE)

################################################################################
### Now, combine the datasets 
################################################################################

library(dplyr)
library(readr)
install.packages("writexl")
library(writexl)

# Set the folder path where CSV files are stored
folder_path <- "/Users/emiryazici/Desktop/Raporlar"  # Change this to your actual folder path

# List all CSV files in the folder
csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

# Read all CSV files and ensure Date is converted to Date format
combined_reports <- csv_files %>%
  lapply(function(file) {
    df <- read_csv(file)  # Read file
    df %>% mutate(Date = ymd(Date))  # Convert Date to proper date format (YYYY-MM-DD)
  }) %>%
  bind_rows()  # Combine all files

# View the first few rows
head(combined_reports)

combined_reports <- combined_reports %>%
  mutate(Date = str_extract(Document, "\\d{4}"))  # Extracts 4-digit year


# Save combined data if needed
write_csv(combined_reports, "combined_reports.csv")

#Save in the excel format for handcoding process (clean messy sentences firsts)
combined_reports <- combined_reports %>%
  select(-Sentence)
write_xlsx(combined_reports, "combined_reports.xlsx")


################################################################################
### Type of Foreign Aid 
################################################################################

# Anahtar kelimeleri liste olarak tanımla
aid_types <- list(
  "İnsani Yardım" = c("afet", "insani yardım", "kriz müdahalesi", "acil", "gıda", "sağlık", "deprem", "yangın", "sel", "barınma", "pandemi", "salgın", "aşı", "tıbbi", "hastane", "halk sağlığı"),
  "Ekonomik, Kalkınma, Teknik ve Altyapı Yardımı" = c("ekonomik", "kalkınma", "kredi", "hibe", "yatırım", "tarım", "ticaret", "finansman", "teşvik", "teşviği", "banka", "ekonomik iş birliği", "altyapı", "özel sektör", "teknik destek", "uzman desteği", "danışmanlık", "mevzuat"),
  "Eğitim ve Kültürel Yardımlar" = c("burs", "eğitim desteği", "öğrenci değişimi", "akademik işbirliği", "okul", "mesleki eğitim", "üniversite", "araştırma", "ibadethane", "cami", "vakıf", "restorasyon"),
  "Askeri ve Güvenlik Yardımı" = c("askeri yardım", "güvenlik", "güvenlik iş birliği", "sınır güvenliği", "terörle mücadele", "askeri eğitim", "polis eğitimi", "savunma sanayii")
)

# Fonksiyon: Cümlede geçen anahtar kelimelere göre yardım türünü belirle
assign_aid_type <- function(sentence) {
  found_types <- sapply(names(aid_types), function(aid_category) {
    any(str_detect(sentence, str_c(aid_types[[aid_category]], collapse = "|")))
  })
  
  # Birden fazla eşleşme varsa türleri virgülle birleştir
  matched_types <- names(found_types)[found_types]
  
  if (length(matched_types) == 0) {
    return(NA) # Eşleşme yoksa NA olarak bırak
  } else {
    return(paste(matched_types, collapse = ", "))
  }
}

# Yardım türlerini belirleyerek yeni sütun ekle
combined_reports <- combined_reports %>%
  mutate(aid_type = sapply(clean_sentence, assign_aid_type))

# Sonuçları göster
print(df)


################################################################################
### Recipient Type of the Foreign Aid (Bypass Aid or not)
################################################################################

# Gerekli kütüphaneleri yükle
library(dplyr)
library(stringr)

# Alıcı aktörlere göre anahtar kelimeler
recipient_types <- list(
  "Merkezi Hükümet ve Bağlı Aktörler" = c("hükümet", "bakanlık", "devlet", "kamu kurumu", "resmi", "merkezi yönetim", "devlet ajansı", "devlet destekli", "ulusal ajans"),
  "Yerel Yönetimler" = c("belediye", "yerel yönetim", "yerel otorite", "il meclisi", "il özel idaresi", "muhtarlık"),
  "Sivil Toplum" = c("sivil toplum", "vakıf", "dernek", "STK", "yerel girişim", "kooperatif")
)

# Fonksiyon: Cümlede hangi alıcı aktörlerin geçtiğini belirle
assign_recipient_type <- function(sentence) {
  found_types <- sapply(names(recipient_types), function(recipient_category) {
    any(str_detect(sentence, str_c(recipient_types[[recipient_category]], collapse = "|")))
  })
  
  matched_types <- names(found_types)[found_types]
  
  if (length(matched_types) == 0) {
    return("Belirsiz") # Eğer hiçbir kategoriye uymuyorsa
  } else {
    return(paste(matched_types, collapse = ", "))
  }
}

# Alıcı türlerini belirleyerek yeni sütun ekle
combined_reports <- combined_reports %>%
  mutate(recipient_type = sapply(clean_sentence, assign_recipient_type))

# Sonuçları göster
print(combined_reports)

write_xlsx(combined_reports, "combined_reports.xlsx")


################################################################################
### Work on the cleaned and hand-coded dataset
################################################################################

codedcombinedreports <- read.csv("~/Desktop/Raporlar/codedcombinedreports.csv", sep=";")

##################
# Drop the irrelevant and iterated variables
#################

library(dplyr)

# Remove rows where Status is "drop"
codedcombinedreports_clean <- codedcombinedreports %>%
  filter(!as.character(Note) %in% c("Drop", "Iteration"))

# View result
print(codedcombinedreports_clean)

##################
# Further data cleaning
#################

# For some observations, aid_types="", assign the right type (error during the hand-coding process)

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 54, "Eğitim ve Kültürel Yardımlar", aid_type))

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 346, "Eğitim ve Kültürel Yardımlar", aid_type))

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(Date = ifelse(row_number() == 137, "2022", Date))

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(Date = ifelse(row_number() == 177, "2018", Date))
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(recipient_type = ifelse(row_number() == 177, "Merkezi Hükümet ve Bağlı Aktörler", recipient_type))

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(recipient_type = ifelse(row_number() == 344, "Sivil Toplum", recipient_type))

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 151, "Ekonomik, Kalkınma, Teknik ve Altyapı Yardımı", aid_type))

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 176, "Ekonomik, Kalkınma, Teknik ve Altyapı Yardımı", aid_type))

codedcombinedreports_clean <- codedcombinedreports_clean %>%
  filter(aid_type != "")

# For some observations, multiple aid types are coded in one row. Create separate rows for each value. (ugly ass code)

# Step 1: Duplicate the row
row_to_duplicate <- codedcombinedreports_clean[247, ]  # Extract row 2
codedcombinedreports_clean <- rbind(codedcombinedreports_clean, row_to_duplicate)  # Add the row back

# Step 2: Change the value for the duplicated rows 
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 247, "Ekonomik, Kalkınma, Teknik ve Altyapı Yardımı", aid_type))  
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 366, "Eğitim ve Kültürel Yardımlar", aid_type))  

# Step 1: Duplicate the row
row_to_duplicate <- codedcombinedreports_clean[66, ]  # Extract row 2
codedcombinedreports_clean <- rbind(codedcombinedreports_clean, row_to_duplicate)  # Add the row back

# Step 2: Change the value for the duplicated rows 
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 66, "İnsani Yardım", aid_type))  
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 367, "Ekonomik, Kalkınma, Teknik ve Altyapı Yardımı", aid_type))  

# Step 1: Duplicate the row
row_to_duplicate <- codedcombinedreports_clean[67, ]  # Extract row 2
codedcombinedreports_clean <- rbind(codedcombinedreports_clean, row_to_duplicate)  # Add the row back

# Step 2: Change the value for the duplicated rows 
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 67, "İnsani Yardım", aid_type))  
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 368, "Ekonomik, Kalkınma, Teknik ve Altyapı Yardımı", aid_type))  

# Step 1: Duplicate the row
row_to_duplicate <- codedcombinedreports_clean[172, ]  # Extract row 2
codedcombinedreports_clean <- rbind(codedcombinedreports_clean, row_to_duplicate)  # Add the row back

# Step 2: Change the value for the duplicated rows 
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 172, "İnsani Yardım", aid_type))  
codedcombinedreports_clean <- codedcombinedreports_clean %>%
  mutate(aid_type = ifelse(row_number() == 369, "Eğitim ve Kültürel Yardımlar", aid_type))  

# Final Version of the Clean Data
write.csv(codedcombinedreports_clean, "codedcombinedreports_clean.csv")

##################
### Summary Stats
##################
# Load necessary packages
library(dplyr)

# Proportion tables
# Create a list of proportion tables for multiple variables
prop_tables <- list(
  prop_country = table(codedcombinedreports_clean$Recipient_Name),
  prop_year = table(codedcombinedreports_clean$Date),
  prop_aidtype = table(codedcombinedreports_clean$aid_type),
  prop_recipient = table(codedcombinedreports_clean$recipient_type)
)

# Convert each table to a dataframe and add proportion column
prop_tables_df <- lapply(prop_tables, function(x) {
  df_table <- as.data.frame(x)
  df_table$Proportion <- df_table$Freq / sum(df_table$Freq)

  # Round the Proportion column (adjust the number of decimals as needed)
  df_table$Proportion <- round(df_table$Proportion, 2)  # Rounded to 2 decimal places
  
  return(df_table)
})

# Export each table to CSV and Excel
for (i in names(prop_tables_df)) {
  write.csv(prop_tables_df[[i]], paste0(i, "_proportion.csv"), row.names = FALSE)
  write_xlsx(prop_tables_df[[i]], paste0(i, "_proportion.xlsx"))
}


### Graphs
library(ggplot2)
library(dplyr)

#Alıcı Ülke_Yardım Türü
cross_freq <- as.data.frame(table(codedcombinedreports_clean$Recipient_Name, codedcombinedreports_clean$aid_type))

# Black-White Bar Plot
ggplot(cross_freq, aes(x = Var1, y = Freq, fill = Var2)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_fill_grey(start = 0.25, end = 0.95) +  # Converts colors to grayscale
  labs(title = "Alıcı Ülkelere Göre Yardım Türlerinin Dağılımı", 
       x = "Alıcı Ülke", y = "Sayı", fill = "Yardım Türü") +
  theme_minimal() +
  theme(legend.position = "bottom")

#Alıcı Ülke_Alıcı Türü
cross_freq <- as.data.frame(table(codedcombinedreports_clean$Recipient_Name, codedcombinedreports_clean$recipient_type))

# Black-White Bar Plot
ggplot(cross_freq, aes(x = Var1, y = Freq, fill = Var2)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_fill_grey(start = 0.25, end = 0.95) +  # Converts colors to grayscale
  labs(title = "Alıcı Ülkelere Göre Yardımı Alan Aktörlerin Dağılımı", 
       x = "Alıcı Ülke", y = "Sayı", fill = "Alıcı Aktör Türü") +
  theme_minimal() +
  theme(legend.position = "bottom")

#Yardım Türü_Alıcı Türü
cross_freq <- as.data.frame(table(codedcombinedreports_clean$aid_type, codedcombinedreports_clean$recipient_type))

# Black-White Bar Plot
ggplot(cross_freq, aes(x = Var1, y = Freq, fill = Var2)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_fill_grey(start = 0.25, end = 0.95) +  # Converts colors to grayscale
  labs(title = "Yardım Türüne Göre Yardımı Alan Aktörlerin Dağılımı", 
       x = "Yardım Türü", y = "Sayı", fill = "Alıcı Aktör Türü") +
  theme_minimal() +
  theme(legend.position = "bottom")


