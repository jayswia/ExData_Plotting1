#set working directory
setwd("C:/R-Coursera/Exploratory Data Analysis CP1")

#load in unzipped delim file
powerdata <- read.delim("./powerdata/household_power_consumption.txt", header=TRUE, sep=";")

#format date filed
powerdata[,1] <- as.Date(powerdata[,1], "%d/%m/%Y")

#determin rows for subsetting
tempyear <- grep("2007-02-01|2007-02-02", powerdata[,1])

#create graph data subset
graphdata <- powerdata[tempyear,]

#format global active power
graphdata$Global_active_power <- as.numeric(paste(graphdata$Global_active_power))

#convert columns to numeric
for(i in c(3:9)) {
        graphdata[,i] <- as.numeric(as.character(graphdata[,i]))
}
#turn on device
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

#create histogram
hist(graphdata$Global_active_power, main="Global Active Power", xlab="Global Active Power", col="red")

#turn off device
dev.off()