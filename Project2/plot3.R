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
    
    # initialise the data frame to hold the emissions totals
    PM25YearTotal <- 
        data.frame( character(), character(), numeric(), 
                    stringsAsFactors=FALSE)
    # initialise the column names
    header <- c("year","src.type","total")
    names(PM25YearTotal) <- header
    
    years <- c("1999","2002","2005","2008")
    src.type <- c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD")
    
    #######################################################################
    ## calculate the emissions for each year/source type combination
    ## and populate the data frame
    #######################################################################
    
    ## extract the Baltimore data
    Baltimore <- NEI[NEI$fips == "24510",]
    
    ## Loop over the source type/year combination to get the total
    ## emissions for the each
    print("Generating the totals")
    for (y in years){
        for (st in src.type){
            src.type.year <- with(Baltimore, (year == y & type == st) )
            
            ## create a new containing the sum of the emissions 
            newrow <- data.frame(y, st, 
                                 sum(Baltimore[src.type.year,]$Emissions), 
                                 stringsAsFactors=FALSE)
            names(newrow) <- header
            # append the new row
            PM25YearTotal<- rbind( PM25YearTotal, newrow )
        } # end of source for
    } # end of year for
    
    ########################################################################
    ## Create the plot  
    ########################################################################
    print("Creating the plot")
    png(file="plot3.png",width = 720, height = 480, units = "px")    
    pl<- qplot(data=PM25YearTotal,
               year, total,
               facets=.~src.type,
               ylab="Number of tons of PM2.5",
                main = "Total yearly PM2.5 emissions for each source 
                    in Baltimore, Maryland, U.S.A."
             )
    print(pl)
    dev.off()
    
} # end of file plotting

##############################################################################
## End of plot3.R
##############################################################################
