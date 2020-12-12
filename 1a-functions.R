###############################################################################
#
### CUSTOM FUNCTIONS
#
###############################################################################

### Create Function(s) for Finding Users/URLs from Hiscores
searchURL <- function(x) { #search for users using hiscores URL
  
  tryNumber <<- 1
  
  while(tryNumber <= 3) { #try and run code a maximum of three times
  
    tryMsg <- try(
                  download.file(x, destfile = "savedPage.html", quiet = TRUE), #download hiscore page
                  silent = TRUE) #silence default error message
  
    if(is(tryMsg, 'try-error')) { #only run following code if error
      
      tryNumber = tryNumber + 1 #add 1 to attempt counter
      
      print(paste("Error accessing page: ",
                  p,
                  ". Beginning attempt: ", #notify user of error
                  tryNumber,
                  " of 3...",))
      
      Sys.sleep(5) #wait five seconds before trying again
      
    } else { #if not error exit while loop
        break #exit out of 'while' loop if download successful
    }
  }
  
  #Find user names on active page(s)
  if (tryNumber <= 3) {
    
    data.table(user = 
               "savedPage.html" %>% 
               read_html() %>% 
               html_nodes("table") %>% #locate correct area of webpage
               html_nodes("a") %>% #node for href (i.e. links)
               html_text("href") #find text displayed by href
              )
    
  } else if (tryNumber > 3) {
      
    print(paste("Unable to access page: ",
                p,
                ". Skipping to next page...",)) #inform user of error
  }
}

createUrl <- function(x) { #generate URL using user info
  
  if (tryNumber <= 3) {
  
  # Create user URL structure
    data.table(url =
                paste0(urlUser, 
                        x$user %>% 
                          str_replace_all("[[:space:]]","%20") #replace spaces with URL-encoded equivalent
                      )
              )
  }
}

### Create Function for Searching Personal Hiscores API

searchUser <- function(x) {
  
  tryNumber <<- 1
  
  while(tryNumber <= 3) {
    
    # Scrape Full User Hiscore
    tryMsg <- try(
      download.file(x, destfile = "personalPage.html", quiet = TRUE), #download hiscore page
      silent = TRUE) #silence default error message
    
    if(is(tryMsg, 'try-error')) { #only run following code if error
      
      tryNumber = tryNumber + 1 #add 1 to attempt counter
      
      print(paste("Error accessing personal hiscore page for: ",
                  users$user[u],
                  ". Beginning attempt: ", #notify user of error
                  tryNumber,
                  " of 3..."))
      
      Sys.sleep(5) #wait five seconds before trying again
      
    } else { #if not error, exit while loop
        break #exit out of 'while' loop if download successful
    }
  }
  
}