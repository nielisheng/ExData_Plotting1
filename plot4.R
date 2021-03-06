##Read data into hpc
hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

##subset date frame into hpc2
hpc2 <- subset(hpc, as.Date(Date, format="%d/%m/%Y")=="2007-02-01" | as.Date(Date, format="%d/%m/%Y")=="2007-02-02")

#conbine Date and Time to a new variable
hpc2$DateTime = paste(hpc2$Date, hpc2$Time)

x <- as.POSIXlt(hpc2$DateTime, tz="", format="%d/%m/%Y %H:%M:%S")
y <- as.POSIXlt("01/02/2007 00:00:00", tz="", format="%d/%m/%Y %H:%M:%S")

#get interval of minitues
hpc2$DTInterval = difftime(x, y, units=c("mins"))

##set graphic device to png
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

##plot 1
plot(hpc2$DTInterval, as.numeric(hpc2$Global_active_power), type="l")

##plot 2
plot(hpc2$DTInterval, as.numeric(hpc2$Voltage), type="l", col="black")

##plot 3
plot(hpc2$DTInterval, as.numeric(hpc2$Sub_metering_1), type="n")
lines(hpc2$DTInterval, as.numeric(hpc2$Sub_metering_1), type="l", col="black")
lines(hpc2$DTInterval, as.numeric(hpc2$Sub_metering_2), type="l", col="red")
lines(hpc2$DTInterval, as.numeric(hpc2$Sub_metering_3), type="l", col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##plot 4
plot(hpc2$DTInterval, as.numeric(hpc2$Global_active_power), type="b")

##shut off png device
dev.off()
