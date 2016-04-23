#### This is simply to munge a bunch of traffic volume data into a list of DFs (for later use) 
#### and a single wide-file. I'll create a data grabber later.

## Load libraries
library(xlsx)

## Create directory vector. Like I said, though, I'll create a data grabber shortly.
dir_list <- list.files("data/traffic_volume")

## Create empty list (for appending DFs to later)
vol_by_month <- list()

## Loop through munging all files per directory, then compiling into one list of DFs.
for(i in 1:length(dir_list)){
    file_list <- list.files(paste0("data/traffic_volume/", dir_list[i]))
    
    for(j in 1:length(file_list)){
        ## Grab file
        month_df <- read.xlsx(paste0("data/traffic_volume/", dir_list[i], "/", file_list[i]), sheetIndex = 6)
        
        ## Cleanup and name
        month_df <- month_df[-c(1:7,17,18,28,29,42,43,52,53,67:72), -c(2:3,8:21)]
        names(month_df) <- c("State","Stations",paste0("Vmiles.",strtrim(file_list[i],5)),"Vmiles.Lastyr","Perc.Change")
        
        ## Append to list
        vol_by_month[[i]] <- month_df
    }
    
}

## Preview full list of DFs. Keeping list for later use.
print(vol_by_month[[1]])

## Create one wide and clean DF/CSV of only Vmiles by month.
## !! Will work on it in the morning !!
