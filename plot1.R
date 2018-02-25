# load data table library
library("data.table")

# file url to be downloaded
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# file download location
fileLocation <- file.path(getwd(), "household_power_consumption.zip")

# download the file
download.file(fileURL, fileLocation)


# unzip the  file
unzip(zipfile = fileLocation, exdir = getwd())


# read the text file
dataPower <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# escape scientific notation
dataPower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


# use data type date 
dataPower[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# two day period only
dataPower <- dataPower[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# set png mode
png("plot1.png", width=480, height=480)


# plot
hist(dataPower[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
