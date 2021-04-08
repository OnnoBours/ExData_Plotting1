# download and save data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

unzip(zipfile="./data/Dataset.zip",exdir="./data")
path_rf <- file.path("./data" , "household_power_consumption.txt")

# read data into R and transform for analysis

epowerconsumption <- read.table(path_rf, header = TRUE, sep = ";")

epowerconsumption$DateTime <- strptime(paste(epowerconsumption$Date, epowerconsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

epowerconsumption$Date <- as.Date(epowerconsumption$Date, format="%d/%m/%Y")
epowerconsumption$Time <- format(epowerconsumption$Time, format="%H:%M:%S")
epowerconsumption$Global_active_power <- as.numeric(epowerconsumption$Global_active_power)
epowerconsumption$Global_reactive_power <- as.numeric(epowerconsumption$Global_reactive_power)

# subset the data by dates

epowerconsumption <- subset(epowerconsumption, Date == "2007-02-01" | Date == "2007-02-02")

# construct the plot and save the 480*480 png

png("plot1.png", width=480, height=480)
with(epowerconsumption, hist(Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)"))
dev.off()
