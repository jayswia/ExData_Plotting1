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
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfcol = c(2,2), mar = c(4,4,2,1), oma = c(0,0,1,0))
        #create plot with no lines (topleft)
        plot(graphdata$Date_Time, graphdata$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")
        
        #create lines
        lines(graphdata$Date_Time, graphdata$Global_active_power, type="S")
                
        #create plot with no lines (bottomleft)
        plot(graphdata$Date_Time, graphdata$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
        
        #create lines
        lines(graphdata$Date_Time, graphdata$Sub_metering_1, type="S")
        lines(graphdata$Date_Time, graphdata$Sub_metering_2, type="S", col="red")
        lines(graphdata$Date_Time, graphdata$Sub_metering_3, type="S", col="blue")
        
        #create legand
        legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

        #create plot with no lines (topright)
        plot(graphdata$Date_Time, graphdata$Voltage, ylab = "Voltage", xlab = "datetime", type="n")
        
        #create lines
        lines(graphdata$Date_Time, graphdata$Voltage, type="S")

        #create plot with no lines (bottomright)
        plot(graphdata$Date_Time, graphdata$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type="n")
        
        #create lines
        lines(graphdata$Date_Time, graphdata$Global_reactive_power, type="S")

#turn off device
dev.off()