###############################################################################
#
### DOWNLOAD OUTPUTS OF SCRAPE.R
#
###############################################################################

timestamp()
print("Generating download file...")

### Create Workbook
wb <- createWorkbook()
addWorksheet(wb, sheetName = "DATA")
addWorksheet(wb, sheetName = "INFO_FILTERS")
addWorksheet(wb, sheetName = "INFO_SKILL")
addWorksheet(wb, sheetName = "INFO_MINIGAME")

### Add Personal Hiscore Data to .xlsx
writeData(wb, sheet = "DATA", hiscores) 
print("Account data added.")

### Add Parameter Info to .xlsx
writeData(wb, sheet = "INFO_FILTERS", accountFilters)
print("Account filters added.")

writeData(wb, sheet = "INFO_SKILL", skills)
writeData(wb, sheet = "INFO_MINIGAME", minigames)
print("Search Parameters added.")

### Save Workbook
filename <- paste0("osrs-hiscores-", Sys.Date(), ".xlsx")
saveWorkbook(wb, file = filename, overwrite = TRUE)

timestamp()
print(paste0("Download complete. File is available as: ", filename))

# Download Complete Message
time_download <- Sys.time()
time_diff4 <- time_download - time_hiscores
print(paste("Download complete. Time taken:",
            round(time_diff4, 1),
            units(time_diff4),
            sep = " "))