library(data.table)
library(dplyr)
library(lubridate)

# Download file and prepare dataset
tmp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tmp)
unzip(tmp, overwrite = TRUE)
file.remove(tmp)

dt <- fread("household_power_consumption.txt", na="?")
dt <- dt %>% mutate(Date= as.Date(Date, "%d/%m/%Y"), daytime= strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))
dt <- dt %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

# Plot1
png("plot1.png", height=480, width=480 )
hist(dt$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="Red")
dev.off()
