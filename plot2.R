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

#convert columns to numeric
for(i in c(3:9)) {
        graphdata[,i] <- as.numeric(as.character(graphdata[,i]))
}

#create Date_Time variable
graphdata$Date_Time <- paste(graphdata$Date, graphdata$Time)

# convert Date_Time variable to proper format
graphdata$Date_Time <- strptime(graphdata$Date_Time, format="%Y-%m-%d %H:%M:%S")

#turn on device
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
#create plot with no lines
plot(graphdata$Date_Time, graphdata$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")

#create lines
lines(graphdata$Date_Time, graphdata$Global_active_power, type="S")

#turn off device
dev.off()