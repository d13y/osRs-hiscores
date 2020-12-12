###############################################################################
#
### GENERATE LIST OF USERS TO SCRAPE
#
###############################################################################

timestamp()
print("Beginning account identification...")
print("Warning: this may take a significant amount of time.")

### Overall/Minigame User Search
if (skillSearch == TRUE) { #SKILL LOOP
  
  time_startSkill <- Sys.time()
  timestamp()
  paste("Beginning skill hiscore search...")
  
  for (t in 1:(skillCount+1)) { #SKILLS TO SCRAPE: 24 total (incl. Overall)
    
    #Check if skill is to be searched
    if (skills$search[t] == TRUE) {
      
      timestamp()
      print(paste0("Now searching ",
                   skills$category[t],
                   " hiscores for the top ",
                   skills$max[t],
                   " users (",
                   skills$pages[t],
                   " pages)."))
      
      for (p in skillStartPage:skills$pages[t]) { #PAGE: First = 1, 25 users per page
        
        # Generate user/personal hiscore info
        activePage <- paste0(urlBase, skills$url[t], "&", "page=", p) #create URL structure
        activeUser <- searchUser(activePage) #generate username
        activeUrl <- createUrl(activeUser) #generate user URL
        
        # Combine DataTables
        activeDT <- cbind(activeUser, activeUrl) #combine both generated values
        users <- rbind(users, activeDT, fill = TRUE) #append individual identifiers to overall user table
        
        unlink("savedPage.html") #removed to prevent clutter
        closeAllConnections() #ensure internet connections are closed
        
        print(paste(skills$category[t],
                    "page",
                    p,
                    "of",
                    skills$pages[t],
                    "completed.",
                    sep = " "))  
        
      }
    } else {
      print(paste(skills$category[t],
                  "skipped as not included in parameter list.",
                  sep = " "))
    }
  }
  
  timestamp()
  time_endSkill <- Sys.time()
  time_diff <- time_endSkill - time_startSkill
  print(paste("All selected skills have been searched and users identified. Time taken:",
              round(time_diff, 1),
              units(time_diff),
              sep = " "))
  
  
} else {
  timestamp()
  print("No skills have been searched due to parameters set.")
}

if (miniSearch == TRUE) { #MINIGAME LOOP
  
  time_startMini <- Sys.time()
  timestamp()
  paste("Beginning activity hiscore search...")
  
  for (t in 1:miniCount) { #MINIGAMES TO SELECT
    
    #Check if minigame is to be searched
    if (minigames$search[t] == TRUE) {
      
      timestamp()
      print(paste0("Now searching ",
                   minigames$category[t],
                   " hiscores for the top ",
                   minigames$max[t],
                   " users (",
                   minigames$pages[t],
                   " pages)."))
      
      for (p in miniStartPage:minigames$pages[t]) { #PAGE: First = 1, 25 users per page
        
        # Generate user/personal hiscore info
        activePage <- paste0(urlBase, minigames$url[t], "&", "page=", p) #create URL structure
        activeUser <- searchURL(activePage) #generate username
        activeUrl <- createUrl(activeUser) #generate user URL
        
        # Combine DataTables
        activeDT <- cbind(activeUser, activeUrl) #combine both generated values
        users <- rbind(users, activeDT, fill = TRUE) #append individual identifiers to overall user table
        
        unlink("savedPage.html") #removed to prevent clutter
        closeAllConnections() #ensure internet connections are closed
        
        print(paste(minigames$category[t],
                    "page",
                    p,
                    "of",
                    minigames$pages[t],
                    "completed.",
                    sep = " ")) 
        
      }
    } else {
      timestamp()
      print(paste(minigames$category[t],
                  "skipped as not included in parameter list.",
                  sep = " "))
    }
  }
  
  timestamp()
  time_endMini <- Sys.time()
  time_diff <- time_endMini - time_startMini
  print(paste("All selected activities have been searched and users identified. Time taken:",
              round(time_diff, 1),
              units(time_diff),
              sep = " "))
  
} else {
  timestamp()
  print("No bosses, minigames or activities have been searched.")
}

timestamp()
time_search <- Sys.time()
time_diff <- time_search - time_setup
print(paste("All accounts found. Time taken:",
            round(time_diff, 1),
            units(time_diff),
            sep = " "))

###############################################################################
#
### FILTER LIST OF USERS TO SCRAPE
#
###############################################################################

### Remove Duplicates and Bugged Account Names
users$error <- users$url %>% grepl("#", .) #identify accounts with account names that aren't searchable
users <- users %>%
  unique() %>% #remove duplicates(s)
  filter(users$error == FALSE) #remove error accounts

timestamp()
print("Duplicates removed (if applicable).")

### Filter out accounts based on parameters.R

# If (and only if) required, remove accounts without numbers in name
if (onlyNumber == TRUE) {
  users <- users[grepl("[0-9]",users$user)]
}

# If (and only if) required, check if users are iron accounts
if (inclIron == FALSE) {
  
  timestamp()  
  print("Removing iron accounts...")
  
  for (i in 1:nrow(users)) { #number of users to search
    
    # Create URL structure
    users$ironUrl[i] <- paste0(urlIron,
                               users$user[i] %>%
                                 str_replace_all("[[:space:]]","%20") #replace spaces with URL-encoded equivalent     
    )
    
    # Check if Account Is on Iron Hiscores
    users$iron[i] <- users$ironUrl[i] %>%
      url.exists() #check that url exists (i.e. does not return 404 error)
    
    closeAllConnections() #ensure internet connections are closed
    
  }
  
  timestamp()
  print("Iron accounts removed.")
  
} else {
  
  for (i in 1:nrow(users)) { #number of users to search
    users$iron[i] <- FALSE #if not checking for iron, set variable to FALSE
  }
  
  timestamp()
  print("Iron accounts included.")
  
}

### Tidy Users DataTables
users <- users[users$iron == FALSE] %>% #remove iron accounts
  subset(select = -c(iron, ironUrl, error)) %>% #remove iron-related columns
  na.omit() #remove any remaining errors
hiscores <- hiscores %>% subset(select = -c(iron, ironUrl))

timestamp()
print("Accounts filtered.")

# Account Identification Completion Message
time_identify <- Sys.time()
time_diff2 <- time_identify - time_search
print(paste("Account identification complete. Time taken:",
            round(time_diff2, 1),
            units(time_diff2),
            sep = " "))