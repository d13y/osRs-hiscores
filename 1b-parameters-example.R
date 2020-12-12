#THIS IS AN EXAMPLE OF THE
#PARAMETERS.R SCRIPT
#THAT WILL ONLY SEARCH THE
#ZULRAH HISCORES
#FOR THE
#TOP 10,000 KILLCOUNTS,
#INCLUDES IRON ACCOUNTS,
#AND EXCLUDES ACCOUNTS WITHOUT NUMBERS IN USERNAME.

#TO RUN THIS EXAMPLE
#SETUP.R
#MUST BE EDITED TO REFERENCE THIS SCRIPT,
#PARAMETERS-EXAMPLE.R,
#INSTEAD OF THE ORIGINAL,
#PARAMETERS.R.

###############################################################################
#
### 'Fixed' Variables
#
###############################################################################
inclIron <- TRUE #TRUE/FALSE to include/exclude iron accounts
onlyNumber <- TRUE #only include accounts with numbers in their name

skillSearch <- FALSE #FALSE = will not search skill hiscores
miniSearch <- TRUE #TRUE = will search minigame hiscores

skillStartPage <- 1 #first page that should be searched (1 = Top 25 accounts...)
miniStartPage <- 1 #first page that should be searched (1 = Top 25 accounts...)

skillPages <- 25 / 1.00 #25 = number of users per page on hiscores; 1.00 = set to take top 100% from 99s pages 
miniPages <- 25 / 1.00 #25 = number of users per page on hiscores; 1.00 = set to take top 100% from score pages

minigames$max <- 10000 #how many users to search for within each minigame?

###############################################################################
#
### SET INDIVIDUAL PARAMETERS FOR SEARCHING SKILLS/MINIGAMES
#
###############################################################################

### Set This Value to TRUE to Run the Code. Will Need Updating if New Skills/Minigames are Released
uniqueSearch <- TRUE

if (uniqueSearch == TRUE) {
  
  ### Skills
  skills$search[skills$category=="Overall"] <- FALSE
  skills$search[skills$category=="Attack"] <- FALSE
  skills$search[skills$category=="Defence"] <- FALSE
  skills$search[skills$category=="Strength"] <- FALSE
  skills$search[skills$category=="Hitpoints"] <- FALSE
  skills$search[skills$category=="Ranged"] <- FALSE
  skills$search[skills$category=="Prayer"] <- FALSE
  skills$search[skills$category=="Magic"] <- FALSE
  skills$search[skills$category=="Cooking"] <- FALSE
  skills$search[skills$category=="Woodcutting"] <- FALSE
  skills$search[skills$category=="Fletching"] <- FALSE
  skills$search[skills$category=="Fishing"] <- FALSE
  skills$search[skills$category=="Firemaking"] <- FALSE
  skills$search[skills$category=="Crafting"] <- FALSE
  skills$search[skills$category=="Smithing"] <- FALSE
  skills$search[skills$category=="Mining"] <- FALSE
  skills$search[skills$category=="Herblore"] <- FALSE
  skills$search[skills$category=="Agility"] <- FALSE
  skills$search[skills$category=="Thieving"] <- FALSE
  skills$search[skills$category=="Slayer"] <- FALSE
  skills$search[skills$category=="Farming"] <- FALSE
  skills$search[skills$category=="Runecraft"] <- FALSE
  skills$search[skills$category=="Hunter"] <- FALSE
  skills$search[skills$category=="Construction"] <- FALSE
  
  ### Minigames
  minigames$search[minigames$category=="Bounty Hunter - Hunter"] <- FALSE
  minigames$search[minigames$category=="Bounty Hunter - Rogue"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (all)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (beginner)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (easy)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (medium)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (hard)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (elite)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (master)"] <- FALSE
  minigames$search[minigames$category=="LMS - Rank"] <- FALSE
  minigames$search[minigames$category=="Abyssal Sire"] <- FALSE
  minigames$search[minigames$category=="Alchemical Hydra"] <- FALSE
  minigames$search[minigames$category=="Barrows Chests"] <- FALSE
  minigames$search[minigames$category=="Bryophyta"] <- FALSE
  minigames$search[minigames$category=="Callisto"] <- FALSE
  minigames$search[minigames$category=="Cerberus"] <- FALSE
  minigames$search[minigames$category=="Chambers of Xeric"] <- FALSE
  minigames$search[minigames$category=="Chambers of Xeric: Challenge Mode"] <- FALSE
  minigames$search[minigames$category=="Chaos Elemental"] <- FALSE
  minigames$search[minigames$category=="Chaos Fanatic"] <- FALSE
  minigames$search[minigames$category=="Commander Zilyana"] <- FALSE
  minigames$search[minigames$category=="Corporeal Beast"] <- FALSE
  minigames$search[minigames$category=="Crazy Archaeologist"] <- FALSE
  minigames$search[minigames$category=="Dagannoth Prime"] <- FALSE
  minigames$search[minigames$category=="Dagannoth Rex"] <- FALSE
  minigames$search[minigames$category=="Dagannoth Supreme"] <- FALSE
  minigames$search[minigames$category=="Deranged Archaeologist"] <- FALSE
  minigames$search[minigames$category=="General Graardor"] <- FALSE
  minigames$search[minigames$category=="Giant Mole"] <- FALSE
  minigames$search[minigames$category=="Grotesque Guardians"] <- FALSE
  minigames$search[minigames$category=="Hespori"] <- FALSE
  minigames$search[minigames$category=="Kalphite Queen"] <- FALSE
  minigames$search[minigames$category=="King Black Dragon"] <- FALSE
  minigames$search[minigames$category=="Kraken"] <- FALSE
  minigames$search[minigames$category=="Kree'Arra"] <- FALSE
  minigames$search[minigames$category=="K'ril Tsutsaroth"] <- FALSE
  minigames$search[minigames$category=="Mimic"] <- FALSE
  minigames$search[minigames$category=="Nightmare"] <- FALSE
  minigames$search[minigames$category=="Obor"] <- FALSE
  minigames$search[minigames$category=="Sarachnis"] <- FALSE
  minigames$search[minigames$category=="Scorpia"] <- FALSE
  minigames$search[minigames$category=="Skotizo"] <- FALSE
  minigames$search[minigames$category=="The Gauntlet"] <- FALSE
  minigames$search[minigames$category=="The Corrupted Gauntlet"] <- FALSE
  minigames$search[minigames$category=="Theatre of Blood"] <- FALSE
  minigames$search[minigames$category=="Thermonuclear Smoke Devil"] <- FALSE
  minigames$search[minigames$category=="TzKal-Zuk"] <- FALSE
  minigames$search[minigames$category=="TzTok-Jad"] <- FALSE
  minigames$search[minigames$category=="Venenatis"] <- FALSE
  minigames$search[minigames$category=="Vet'ion"] <- FALSE
  minigames$search[minigames$category=="Vorkath"] <- FALSE
  minigames$search[minigames$category=="Wintertodt"] <- FALSE
  minigames$search[minigames$category=="Zalcano"] <- FALSE
  minigames$search[minigames$category=="Zulrah"] <- TRUE
  
}