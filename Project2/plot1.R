#############################################################################
## 
## Plot 1.R: 
##
## 1. Have total emissions from PM2.5 decreased in the United States from 
##    1999 to 2008? Using the base plotting system, make a plot showing 
##    the total PM2.5 emission from all sources for each of the years
##    1999, 2002, 2005, and 2008.
##
#############################################################################

#############################################################################
## Download the data 
#############################################################################
DataDir <-"data"
FileURL <- 
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists(DataDir)){
    print("Creating directory for downloading data ...")
    dir.create(DataDir)
    ###########################################################################
    ## Download the file into the Create directory 
    ###########################################################################
    download.file(FileURL, 
                  destfile = paste("./",DataDir,"/Dataset.zip",sep=""))
    ###########################################################################
    ## Add a file that contains the time and date the data is downloaded 
    ###########################################################################
    dateFileCon<-file("./data/DateDataDownloaded","w")
    dateDownloaded <- date()
    write(dateDownloaded,dateFileCon)
    close(dateFileCon)
    ###########################################################################
    ## Unzip the archive into ./data
    ###########################################################################
    setwd(DataDir)
    unzip("Dataset.zip")
    setwd("..")
} 

##############################################################################
## Check that summarySCC_PM25.rds and Source_Classification_Code.rds
## are in the data directory
##############################################################################
print(
    "Checking summarySCC_PM25.rds and Source_Classification_Code.rds exist ...")

dirlist<-dir(DataDir)
if (("summarySCC_PM25.rds" %in% dirlist) 
    && ("Source_Classification_Code.rds" %in% dirlist)){
    print("Data files exist")
    #########################################################################
    ## Read the data
    #########################################################################
    
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS(paste(DataDir,"summarySCC_PM25.rds",sep="/"))
    SCC <- readRDS(paste(DataDir,"Source_Classification_Code.rds",sep="/"))
    
    ########################################################################
    ## Create a data frame with the total PM2.5 emission from all sources 
    ## for each of the years 1999, 2002, 2005, and 2008.
  
    > by(df$Sepal.Width,df$Species,sum)
    df$Species: setosa
    [1] 171.4
    --------------------------------------------------------------- 
        df$Species: versicolor
    [1] 138.5
    --------------------------------------------------------------- 
        df$Species: virginica
    [1] 148.7
    
    
} 



