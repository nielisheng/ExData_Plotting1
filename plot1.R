##Read data into hpc
hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

##subset date frame into hpc2
hpc2 <- subset(hpc, as.Date(Date, format="%d/%m/%Y")=="2007-02-01" | as.Date(Date, format="%d/%m/%Y")=="2007-02-02")

##set graphic device to png
png(filename="plot1.png", width=480, height=480)

##plot histgram
hist(as.numeric(hpc2$Global_active_power), col="red")

##shut off png device
dev.off()
