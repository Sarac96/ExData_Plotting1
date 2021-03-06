library(data.table)
library(dplyr)
library(lubridate)

# Download file and prepare dataset
if (!file.exists("household_power_consumption.txt")) {
    tmp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tmp)
    unzip(tmp, overwrite = TRUE)
    file.remove(tmp)
}

dt <- fread("household_power_consumption.txt", na="?")
dt <- dt %>% mutate(Date= as.Date(Date, "%d/%m/%Y"), daytime= strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))
dt <- dt %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

# Plot3
png("plot3.png", height=480, width=480)
plot(x=dt$daytime, dt$Sub_metering_1, type="l", ylab="Energy sub metering", xlab=NA)
points(type="l", x=dt$daytime, dt$Sub_metering_2, col="red")
points(type="l", x=dt$daytime, dt$Sub_metering_3, col="blue")
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1)
dev.off()