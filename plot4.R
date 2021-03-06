#reading in the data:
data <- read.table("household_power_consumption.txt",sep=";", header = T, stringsAsFactors = F, na.strings = "?")

#Reformatting the date from character to date format, and then subsetting only the 2 dates required:
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
subset <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#reformat time from char to time format in the subset:
subset$Time<-strptime(paste(subset$Date, subset$Time), format = "%Y-%m-%d %H:%M:%S")

#convert time to POSIXct:
subset$Time<-as.POSIXlt(subset$Time)
#plot separate graphs on screen graphics device, set par defining mfrow and margins for all graphs:
par(mfrow=c(2,2),mar=c(4.1,4.1,2,1))
with(subset,{plot(Time,Global_active_power, type = 'l',ylab = "Global Active Power", xlab = "")
  plot(Time,Voltage, type = 'l',ylab = "Voltage", xlab = "datetime")
  {plot(Time,Sub_metering_1, type = 'l',ylab = "Energy Sub Metering", xlab = "")
    lines(Time,Sub_metering_2, col = 'red', type = 'l',ylab = "", xlab = "")
    lines(Time,Sub_metering_3, col = 'blue', type = 'l',ylab = "", xlab = "")
    legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = "solid", col = c("black","red","blue"))
  }
  plot(Time,Global_reactive_power, type = 'l',ylab = "Global_reactive_power", xlab = "datetime")
})

#copy graph from screen graphics device to file device, while resizing to required dimensions:
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
