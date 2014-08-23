#############################################################################
## 
## Coursera Exploratory Data Analysis: Project 2
##
## plot 2.R: This script answers the 2nd question in the project, that is
##    2. Have total emissions from PM2.5 decreased in the Baltimore City, 
##       Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
##       system to make a plot answering this question.
##
##    The plot is output into a file plot2.png
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
  print("Data files exist, reading data ....")
  #########################################################################
  ## Read the data
  #########################################################################
  
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS(paste(DataDir,"summarySCC_PM25.rds",sep="/"))
  SCC <- readRDS(paste(DataDir,"Source_Classification_Code.rds",sep="/"))
  
  ########################################################################
  ## Create a data frame with the yearly totals PM2.5 emission from 
  ## all sources for Baltimore, Maryland (fips == "24510")
  ## between 1999 and 2008.
  ########################################################################
  
  print("Calculating yearly PM2.5 totals for Baltimore")
  PM25YearTotal <- data.frame(year=c(1999,2002,2005,2008), total=NA)
  
  for (y in PM25YearTotal$year){
    ## Get the baltimore emissions
    Baltimore <- with (NEI, (fips == "24510" & year == y))  
    PM25YearTotal[PM25YearTotal$year == y,]$total =
           sum(NEI[Baltimore,]$Emissions)
  }
  
  ########################################################################
  ## Create a bar plot  
  ########################################################################
  
  png(file="plot2.png",width = 480, height = 480, units = "px")    
  with(PM25YearTotal,
       barplot(total,
               main =
                 "Total yearly PM2.5 emissions  
                  from all sources in Baltimore, Maryland, U.S.A.",
               ylab="Number of tons of PM2.5",
               xlab = "Year",
               names.arg=year
       ) # end barplot
  ) # end with
  dev.off()
  
} # end of file plotting

##############################################################################
## End of plot2.R
##############################################################################
