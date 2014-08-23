#############################################################################
## 
## Coursera Exploratory Data Analysis: Project 2
##
## plot 3.R: This script answers the 3rd question in the project, that is
##           3. Of the four types of sources indicated by the type 
##              (point, nonpoint, onroad, nonroad) variable, which of these 
##              four sources have seen decreases in emissions from 1999 to 2008
##              for Baltimore City? Which have seen increases in emissions 
##              from 1999 to 2008? Use the ggplot2 plotting system to make a 
##              plot answer this question.
##
##    The plot is output into a file called plot3.png
##
#############################################################################

library(ggplot2)

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
  ## Create a data frame with the yearly total PM2.5 emissions 
  ## for each source type ie. point, nonpoint, onroad, nonroad
  ## for Baltimore, Maryland (fips == "24510") between 1999 and 2008.
  ########################################################################
  
  Baltimore <- with ( NEI, (fips == "24510") )
  
#  print("Calculating yearly PM2.5 totals for Baltimore")
#  PM25YearTotal <- 
#    data.frame( year=c(1999,2002,2005,2008), 
#                stype=c("POINT", "NONPOINT", "ONROAD", "NONROAD"),
#                total=NA,stringsAsFactors=FALSE)
  
#  for (y in PM25YearTotal$year){
#    for (st in PM25YearTotal$stype){
        ## Get entries for the Baltimore emissions for each source type in
        ## a particular year
#        Baltimore <- with ( NEI, (fips == "24510" & year == y & type == st) )
        ## set the mask for the PM25YearTotal$year and
        ## PM25YearTotal$stype combination
#        year.stype <- with(PM25YearTotal, (year == y & stype == st) )
        ## sum the emission for each source type and year in Baltimore
#        PM25YearTotal[year.stype,]$total = sum(NEI[Baltimore,]$Emissions)
#    } # end of source for
#  } # end of year for
  
  ########################################################################
  ## Create a bar plot  
  ########################################################################
  
#  png(file="plot3.png",width = 480, height = 480, units = "px")    
#  with(PM25YearTotal,
#       barplot(total,
#               main =
#                 "Total yearly PM2.5 emissions  
#                  from all sources in Baltimore, Maryland, U.S.A.",
#               ylab="Number of tons of PM2.5",
#               xlab = "Year",
#               names.arg=year
#       ) # end barplot
#  ) # end with
#  dev.off()
  
} # end of file plotting

##############################################################################
## End of plot2.R
##############################################################################
