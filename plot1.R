#reading in the data:
data <- read.table("household_power_consumption.txt",sep=";", header = T, stringsAsFactors = F, na.strings = "?")

#Reformatting the date from character to date format, and then subsetting only the 2 dates required:
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
subset <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#reformat time from char to time format in the subset:
subset$Time<-strptime(paste(subset$Date, subset$Time), format = "%Y-%m-%d %H:%M:%S")

#plot histogram on screen graphics device:
with(subset, hist(Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

#copy graph from screen graphics device to file device, while resizing to required dimensions:
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
