#############################################################################
## 
## Coursera Exploratory Data Analysis: Project 2
##
## plot 5.R: This script answers the 5th question in the project, that is
##           5. How have emissions from motor vehicle sources changed from 
##              1999 to 2008 in Baltimore City?
##
##    The plot is output into a file called plot5.png
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
    ## using unique(SSC$EI.Sector) shows that The EI.Sector field in the 
    ## SCC data indicates sources classified as
    ## Mobile - On-Road Gasoline Light Duty Vehicles     
    ## Mobile - On-Road Gasoline Heavy Duty Vehicles     
    ## Mobile - On-Road Diesel Light Duty Vehicles       
    ## Mobile - On-Road Diesel Heavy Duty Vehicles  
    ##
    ## Get the Source Codes for all the sources with these
    ## values in the EI.Sector field
    ########################################################################
    
    MotorIndex<-grep("([Mm]obile)(.*)([Vv]ehicles)",SCC$EI.Sector)
    SCC.List<-as.character(SCC[MotorIndex,]$SCC)
    
    # initialise the data frame to hold the emissions totals
    PM25YearTotal <- 
        data.frame( character(), numeric(), stringsAsFactors=FALSE)
    # initialise the column names
    header <- c("year", "total")
    names(PM25YearTotal) <- header
    
    years <- c("1999","2002","2005","2008")
    
    ## extract the Baltimore data
    Baltimore <- NEI[NEI$fips == "24510",]
    
    ## Loop over the year to get the total emissions for each
    print("Generating the totals")
    for (y in years){
        motor.year <- with(Baltimore,(SCC %in% SCC.List) & year == y)
        ## create a new containing the sum of the emissions 
        newrow <- data.frame(y,  
                             sum(Baltimore[motor.year,]$Emissions), 
                             stringsAsFactors=FALSE)
        names(newrow) <- header
        # append the new row
        PM25YearTotal<- rbind( PM25YearTotal, newrow )
    } # end of
    
    ########################################################################
    ## Create a bar plot  
    ########################################################################
    print("Creating the plot")
    png(file="plot5.png",width = 480, height = 480, units = "px")    
    with(PM25YearTotal,
         barplot(total,
                 main =
                     "Total yearly PM2.5 emissions from on-road motor
                 vehicles in Baltimore City, Maryland, U.S.A.",
                 ylab=" Number of tons of PM2.5",
                 xlab = "Year",
                 names.arg=year
         )
    )
    dev.off()
    
} # end of file plotting

##############################################################################
## End of plot5.R
##############################################################################
