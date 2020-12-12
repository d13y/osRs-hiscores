###############################################################################
#
### SCRAPE HISCORES API FOR FULL USERS DETAILS
#
###############################################################################

timestamp()
print("Searching RS API for all individual account stats...")
print("Warning: this may take a significant amount of time.")

for (u in 1:nrow(users)) { #number of users to search
  
  #Create Empty Temporary User Hiscore
  tempHiscores <- data.table(user = users$user[u],
                             url = users$url[u]
  )
  tempHiscores <- cbind(tempHiscores, hiHeader)
  
  # Access function to search personal hiscores
  searchUser(users$url[u])
  
  if (tryNumber <= 3) { #only run following code if successful scrape
    
    apiUser <- "personalPage.html" %>%
      read_html() %>%
      html_text() %>% #find all text on webpage
      gsub("\n", ",", .) %>% #remove line breaks (/n) with comma; '.' represents %>% input as not first argument
      gsub("-1", "0", .) #remove -1 error with 0
    
    apiStats <- as.data.table( #separates long string into list 
      as.numeric( #convert to number
        unlist(
          str_split(apiUser, ",") #remove commas
        )))
    
    # Extract Stats (Experience/Score) from API string
    for (s in 0:skillCount) { #number of skills (incl. Overall)
      tempHiscores[1, (s+3)] <- apiStats[(3+(s*3)), 1] #to avoid user/url rows in tempHiscores, and skip skill rank/level in apiStats
    }
    
    for (s in 1:miniCount) { #number of minigames (excl. League Points)
      tempHiscores[1, (s+3+skillCount)] <- apiStats[(3+(skillCount*3)+2+(s*2)), 1] #to avoid user/url/skill rows in tempHiscores, and skip skill stats/leagues/minigame ranks
    }
    
    hiscores <<- rbind(hiscores, tempHiscores) #append to main DataTable
    
    unlink("personalPage.html") #removed to prevent clutter
    closeAllConnections() #ensure internet connections are closed
    
    print(paste("User:",
                users$user[u],
                "added to hiscore database.",
                u,
                "of",
                nrow(users),
                "completed.",
                sep = " "))
    
  } else if (tryNumber > 3) {
    print(paste("Unable to access page. Skipping to next user...")) #inform user of error
  }
  
}

timestamp()
print("All accounts searched.")

# Personal Hiscore Scraping Completion Message
time_hiscores <- Sys.time()
time_diff3 <- time_hiscores - time_identify
print(paste("Stat compilation for all identified accounts complete. Time taken:",
            round(time_diff3, 1),
            units(time_diff3),
            sep = " "))