#############################################################################
## 
## Coursera Exploratory Data Analysis: Project 2
##
## plot 4.R: This script answers the 4th question in the project, that is
##           4. Across the United States, how have emissions from coal 
##              combustion-related sources changed from 1999?2008?
##
##    The plot is output into a file called plot4.png
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
    
    # The EI.Sector field in the SCC data contains Comb for Combustion
    # and Coal for coal for Combustion Coal sources
    # Get the Source Codes for these sources
    CombCoalIndex<-grep("([Cc]omb)(.*)([Cc]oal)",SCC$EI.Sector)
    SCC.List<-as.character(SCC[CombCoalIndex,]$SCC)
    
    # initialise the data frame to hold the emissions totals
    PM25YearTotal <- 
        data.frame( character(), numeric(), stringsAsFactors=FALSE)
    # initialise the column names
    header <- c("year", "total")
    names(PM25YearTotal) <- header
    
    years <- c("1999","2002","2005","2008")
    
    ## Loop over the year to get the total
    ## emissions for the each
    print("Generating the totals")
    for (y in years){
        coal.year <- with(NEI,(SCC %in% SCC.List) & year == y)
        ## create a new containing the sum of the emissions 
        newrow <- data.frame(y,  
                             sum(NEI[coal.year,]$Emissions), 
                             stringsAsFactors=FALSE)
        names(newrow) <- header
        # append the new row
        PM25YearTotal<- rbind( PM25YearTotal, newrow )
    } # end of
    
    ########################################################################
    ## Create a bar plot  
    ########################################################################
    print("Creating the plot")
    png(file="plot4.png",width = 480, height = 480, units = "px")    
    with(PM25YearTotal,
         barplot(total,
                 main =
                     "Total yearly PM2.5 emissions from Coal
                       Combustion-related sources in the U.S.A.",
                ylab=" Number of tons of PM2.5",
                xlab = "Year",
                names.arg=year
        )
    )
    dev.off()

} # end of file plotting

##############################################################################
## End of plot4.R
##############################################################################
