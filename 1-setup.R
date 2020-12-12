###############################################################################
#
### Initialisation
#
###############################################################################

### Start Up
print("Beginning setup...")
print("Loading packages...")

### Packages
library(tidyverse) #contains multitude to commonly used & useful packages
library(rvest) #webscraping functions
library(RCurl) #supports rvest functions
library(data.table) #faster and more efficient than using dataframes
library(openxlsx) #required to create/download end results

print("Packages loaded.")

### URLs
urlBase <- "https://secure.runescape.com/m=hiscore_oldschool/"
urlMain <- "https://secure.runescape.com/m=hiscore_oldschool/overall"
urlUser <- "https://secure.runescape.com/m=hiscore_oldschool/index_lite.ws?player=" #username suffix
urlIron <- "https://secure.runescape.com/m=hiscore_oldschool_ironman/index_lite.ws?player=" #username suffix
urlWiki <- "https://oldschool.runescape.wiki/w/Template:99s?action=edit" #wiki URL with no. of 99s for each skill in plain text

timestamp()
print("URL templates created.")

###############################################################################
#
### Generate Empty Hiscores & Users DataTables
#
###############################################################################

timestamp()
print("Locating hiscore page structure...")

### Load in the Hiscore Page Details
hiPage <- urlMain %>% #load in page URLs
  read_html() %>% 
  html_nodes("a") #identify links

hiTable <- data.table(fullUrl =
                        hiPage %>% #create basic hiscore table
                        html_attr("href")
)

print("Hiscore page structure copied.")
print("Extracting required information from page...")

hiTable$category <- hiPage %>% #extract skill/minigame names
  html_text("href") %>%
  str_remove_all("\n")

closeAllConnections() #ensure internet connections are closed

### Generate Identifier Columns
hiTable$flag <- grepl("*#headerHiscores", hiTable$fullUrl) #flag all hiscore-related URLs
hiTable$mini <- grepl("*category_type*", hiTable$fullUrl) #flag minigames only 
hiTable$skill <- (hiTable$flag == TRUE) & (hiTable$mini == FALSE) #flag skills only
hiTable$url <- hiTable$fullUrl %>% str_remove("#headerHiscores") #remove suffix for use in future scrape

hiTable$id <- hiTable$fullUrl %>% 
  str_extract("[0-9]+#") %>% #extract hiscore table numbers
  str_remove("#") %>% #remove extra characters
  as.numeric() #convert to numbers

### Generate DataTables for Skills/Minigames
skills <- hiTable %>% #create skills info datatable
  filter(skill == TRUE) %>%
  select(c(url, category, id)) #only include required columns

minigames <- hiTable %>% #create minigames info datable
  filter(mini == TRUE) %>%
  select(c(url, category, id)) #only include required columns

skills$search <- TRUE #TRUE = scrape specific skill (default is TRUE for all)
skills$search[skills$category=="Overall"] <- FALSE #no need to search maxed players
minigames$search <- TRUE #TRUE = scrape specific minigame (default is TRUE for all)

### Generate DataTable for Hiscores (incl. for both users and skills/minigames)
hiHeader <- data.table(t( #transpose data table
  hiTable$category[which(hiTable$flag == TRUE)])) #remove any rows that aren't skills/minigames

names(hiHeader) <- as.character(hiHeader) %>% #rename columns to respective skills/minigames
  str_remove_all("\n") #remove line-break characters

hiHeader[1,] <- NA #clear names from first row

users <- data.table(user=NA, iron=NA, url = NA, ironUrl = NA) %>% 
  na.omit () #create empty user database
hiscores <- cbind(users, hiHeader) %>% 
  na.omit() # create empty hiscores database

### Number of Skills/Minigames
skillCount <- nrow(skills) -1 #-1 to remove 'Overall'
miniCount <- nrow(minigames)

timestamp()
print("Empty hiscores and accounts databases created.")

###############################################################################
#
### IDENTIFY HOW MANY USERS TO SCRAPE PER SKILL/MINIGAME
#
###############################################################################

timestamp()
print("Search OSRS wiki for skill mastery information...")

### SKILLS: Load in the Wiki Page Details
wikiPage <- urlWiki %>% #load in wiki URL
  read_html() %>%
  html_nodes("#wpTextbox1") #to find the correct area on page

wikiTable <- wikiPage %>% 
  html_text() %>% #convert to string to identify text
  read_table() %>% #return string as table separated by line breaks
  as.data.table() %>%
  rename(table = 1) #renamed to make future actions easier

closeAllConnections() #ensure internet connections are closed

print("Skill mastery information identified.")
print("Extracting required information from page...")

# Identify Skills, and Generate Columns for Key Values             
wikiSkills <- wikiTable[str_detect(wikiTable$table, "="), ] #remove rows without likely skill identifiers
wikiSkills$format <- wikiSkills$table %>% str_remove("\\|") #remove '|' character
wikiSkills$category <- wikiSkills$format %>% str_remove("=.*") #remove all but skill name

wikiSkills$max <- wikiSkills$format %>%
  str_remove(".*=") %>% #remove all but number of 99s
  str_remove(",") %>% as.numeric() #remove comma, to convert to numeric

# Clean Up DataTable
wikiSkills <- wikiSkills %>%
  na.omit() %>% #remove any leftover non-skill rows
  select(-c(table, format)) #remove extra columns

timestamp()
print("Skill mastery information extracted")

###############################################################################
#
### SOURCE OTHER .R SCRIPTS (FUNCTIONS.R & PARAMETERS.R)
#
###############################################################################

timestamp()
print("Sourcing other files...")

### Source Files
source("./1a-functions.R")

print("Custom functions created.")

source("./1b-parameters.R")

print("Parameters updated.")

### Use Sources to Finalise DataTables
wikiSkills$pages <- ceiling(wikiSkills$max / skillPages) #final number of pages to search

# Merge with Skills Datatable
skills <- merge(skills, wikiSkills) #combine at category match
# Generate Minigames equivalent
minigames$pages <- ceiling(minigames$max / miniPages) #final number of minigames pages to search
#Generate Account Parameter Table
accountFilters <- data.table("Include Ironmen?" = inclIron,
                             "Only Include Accounts With Numbers in Name?" = onlyNumber)

timestamp()
print("Empty datatables initialised.")

# Setup Completion Message
time_setup <- Sys.time()
time_diff1 <- time_setup - time_start
print(paste("Setup complete. Time taken:",
            round(time_diff1, 1),
            units(time_diff1),
            sep = " "))