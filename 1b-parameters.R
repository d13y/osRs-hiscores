###############################################################################
#
### 'Fixed' Variables
#
###############################################################################
inclIron <- TRUE #TRUE/FALSE to include/exclude iron accounts
inclNumber <- TRUE #only include accounts with numbers in their name

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
  skills$search[skills$category=="Attack"] <- TRUE
  skills$search[skills$category=="Defence"] <- TRUE
  skills$search[skills$category=="Strength"] <- TRUE
  skills$search[skills$category=="Hitpoints"] <- TRUE
  skills$search[skills$category=="Ranged"] <- TRUE
  skills$search[skills$category=="Prayer"] <- FALSE
  skills$search[skills$category=="Magic"] <- TRUE
  skills$search[skills$category=="Cooking"] <- FALSE
  skills$search[skills$category=="Woodcutting"] <- TRUE
  skills$search[skills$category=="Fletching"] <- FALSE
  skills$search[skills$category=="Fishing"] <- TRUE
  skills$search[skills$category=="Firemaking"] <- TRUE
  skills$search[skills$category=="Crafting"] <- TRUE
  skills$search[skills$category=="Smithing"] <- TRUE
  skills$search[skills$category=="Mining"] <- TRUE
  skills$search[skills$category=="Herblore"] <- FALSE
  skills$search[skills$category=="Agility"] <- FALSE
  skills$search[skills$category=="Thieving"] <- TRUE
  skills$search[skills$category=="Slayer"] <- FALSE
  skills$search[skills$category=="Farming"] <- TRUE
  skills$search[skills$category=="Runecraft"] <- TRUE
  skills$search[skills$category=="Hunter"] <- TRUE
  skills$search[skills$category=="Construction"] <- FALSE
  
  ### Minigames
  minigames$search[minigames$category=="Bounty Hunter - Hunter"] <- TRUE
  minigames$search[minigames$category=="Bounty Hunter - Rogue"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (all)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (beginner)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (easy)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (medium)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (hard)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (elite)"] <- FALSE
  minigames$search[minigames$category=="Clue Scrolls (master)"] <- FALSE
  minigames$search[minigames$category=="LMS - Rank"] <- TRUE
  minigames$search[minigames$category=="Abyssal Sire"] <- FALSE
  minigames$search[minigames$category=="Alchemical Hydra"] <- FALSE
  minigames$search[minigames$category=="Barrows Chests"] <- TRUE
  minigames$search[minigames$category=="Bryophyta"] <- FALSE
  minigames$search[minigames$category=="Callisto"] <- FALSE
  minigames$search[minigames$category=="Cerberus"] <- FALSE
  minigames$search[minigames$category=="Chambers of Xeric"] <- TRUE
  minigames$search[minigames$category=="Chambers of Xeric: Challenge Mode"] <- TRUE
  minigames$search[minigames$category=="Chaos Elemental"] <- FALSE
  minigames$search[minigames$category=="Chaos Fanatic"] <- FALSE
  minigames$search[minigames$category=="Commander Zilyana"] <- TRUE
  minigames$search[minigames$category=="Corporeal Beast"] <- TRUE
  minigames$search[minigames$category=="Crazy Archaeologist"] <- FALSE
  minigames$search[minigames$category=="Dagannoth Prime"] <- TRUE
  minigames$search[minigames$category=="Dagannoth Rex"] <- TRUE
  minigames$search[minigames$category=="Dagannoth Supreme"] <- TRUE
  minigames$search[minigames$category=="Deranged Archaeologist"] <- FALSE
  minigames$search[minigames$category=="General Graardor"] <- TRUE
  minigames$search[minigames$category=="Giant Mole"] <- TRUE
  minigames$search[minigames$category=="Grotesque Guardians"] <- FALSE
  minigames$search[minigames$category=="Hespori"] <- FALSE
  minigames$search[minigames$category=="Kalphite Queen"] <- TRUE
  minigames$search[minigames$category=="King Black Dragon"] <- FALSE
  minigames$search[minigames$category=="Kraken"] <- FALSE
  minigames$search[minigames$category=="Kree'Arra"] <- TRUE
  minigames$search[minigames$category=="K'ril Tsutsaroth"] <- TRUE
  minigames$search[minigames$category=="Mimic"] <- FALSE
  minigames$search[minigames$category=="Nightmare"] <- TRUE
  minigames$search[minigames$category=="Obor"] <- FALSE
  minigames$search[minigames$category=="Sarachnis"] <- TRUE
  minigames$search[minigames$category=="Scorpia"] <- FALSE
  minigames$search[minigames$category=="Skotizo"] <- FALSE
  minigames$search[minigames$category=="The Gauntlet"] <- TRUE
  minigames$search[minigames$category=="The Corrupted Gauntlet"] <- TRUE
  minigames$search[minigames$category=="Theatre of Blood"] <- TRUE
  minigames$search[minigames$category=="Thermonuclear Smoke Devil"] <- FALSE
  minigames$search[minigames$category=="TzKal-Zuk"] <- FALSE
  minigames$search[minigames$category=="TzTok-Jad"] <- FALSE
  minigames$search[minigames$category=="Venenatis"] <- FALSE
  minigames$search[minigames$category=="Vet'ion"] <- FALSE
  minigames$search[minigames$category=="Vorkath"] <- TRUE
  minigames$search[minigames$category=="Wintertodt"] <- TRUE
  minigames$search[minigames$category=="Zalcano"] <- TRUE
  minigames$search[minigames$category=="Zulrah"] <- TRUE
  
}
