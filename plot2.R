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

# use datetime format
dataPower[, dateTimeSelect := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# two day period only
dataPower <- dataPower[(dateTimeSelect >= "2007-02-01") & (dateTimeSelect < "2007-02-03")]

# set png mode
png("plot2.png", width=480, height=480)

# plot
plot(x = dataPower[, dateTimeSelect]
     , y = dataPower[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()


