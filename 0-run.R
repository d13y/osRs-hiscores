{

  timestamp()
  time_start <- Sys.time()
  
  ### Setup
  source("./1-setup.R")
  
  ### Account Identification
  source("./2-identify.R")
  
  ### Personal Hiscores
  source("./3-personal.R")
  
  ### Download Results
  source("./4-download.R")
  
  ### Overall Completion Message
  time_finish <- Sys.time()
  time_diff <- time_finish - time_start
  print(paste("Time taken for entire script:",
              round(time_diff, 1),
              units(time_diff),
              sep = " "))
  
}