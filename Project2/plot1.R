#############################################################################
## 
## Coursera Exploratory Data Analysis: Project 2
##
## plot 1.R: This script answers the first question in the project, that is
##    1. Have total emissions from PM2.5 decreased in the United States from 
##       1999 to 2008? Using the base plotting system, make a plot showing 
##       the total PM2.5 emission from all sources for each of the years
##       1999, 2002, 2005, and 2008.
##    The plot is output into a file plot1.png
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
} # end of data download

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
    ########################################################################
    
    print("Calculating yearly PM2.5 totals")
    PM25TotalPerYear <-data.frame(year=c(1999, 2002, 2005, 2008), 
                                  total=c(NA,NA,NA,NA))
    
    for (y in PM25TotalPerYear$year){
        PM25TotalPerYear[PM25TotalPerYear$year == y,]$total = 
            sum(NEI[NEI$year == y,]$Emissions)
    }
 
    ########################################################################
    ## Create a bar plot  
    ########################################################################
    
    png(file="plot1.png",width = 480, height = 480, units = "px")    
    with(PM25TotalPerYear,
         barplot(total,
            main =
                "Total yearly PM2.5 emissions  
                 from all sources in the U.S.A.",
            ylab=" Number of tons of PM2.5",
            xlab = "Year",
            names.arg=year
            )
    )
    dev.off()
    
} # end of file plotting

##############################################################################
## End of plot1.R
##############################################################################

