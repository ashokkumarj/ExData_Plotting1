
# read the input household power consumption data 
# assumes that the pwd is exploratoryAnalysis folder 
data <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",stringsAsFactors = FALSE)

# subset only power consumption data for dates 1/2/2007 and 2/2/2007
data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007") ,]

# combine Date and Time string variables 
datetime <- paste(data$Date, data$Time)

# Create datetime variable 
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

# column bind datetime with the rest of the features
data <- cbind(datetime,data)

# drop Date and Time variables 
data <- subset(data, select = -c(Date,Time) )

# Create a png bitmap graphics file device with 480x480 pixel dimension
png(filename="plot3.png", width = 480, height = 480,  units = "px")

# Create the required plot
plot(data$datetime, data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")

lines(data$datetime, data$Sub_metering_2,ylab="Energy sub metering",xlab="",col="red") 

lines(data$datetime, data$Sub_metering_3,ylab="Energy sub metering",xlab="",col="blue")

legend('topright', names(data)[c(6,7,8)] , lty=1, col=c('black', 'red', 'blue'))

# close the png device
dev.off()