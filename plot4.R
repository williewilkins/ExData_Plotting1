setwd("C://Project1")
getwd()

dataset <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

data <- subset(dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataset)

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)


par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~Datetime, type="l", ylab="Active Power (kW)", xlab="")
    plot(Voltage~Datetime, type="l", ylab="Voltage (V)", xlab="")
    plot(Sub_metering_1~Datetime, type="l", ylab="Active Power (kW)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub Meter 1", "Sub Meter 2", "Sub Meter 3"))
    plot(Global_reactive_power~Datetime, type="l", ylab="Re-Active Power (kW)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
