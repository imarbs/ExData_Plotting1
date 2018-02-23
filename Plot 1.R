setwd("Z:/Machine Learning")

library(readr)
library(dplyr)

# Prelimenary -------------------------------------------------------------

#Read file with Time variable specified to time format
household_power_consumption <- read_delim(
    "Z:/Machine Learning/household_power_consumption.txt",";", 
    escape_double = FALSE, col_types = cols(
        Time = col_time(format = "%H:%M:%S")), trim_ws = TRUE, na = c("?"))

#Date specified format to date
household_power_consumption$Date <- as.Date(
    household_power_consumption$Date, "%d/%m/%Y")

#Subset dates between 2007-02-01 and 2007-02-02 
household_power_consumption <- subset(
    household_power_consumption, Date >= as.Date("2007-02-01", "%Y-%m-%d")
    & Date <= as.Date("2007-02-02", "%Y-%m-%d"))

#Create datetime variable, very useful for time-series analysis   

household_power_consumption <- mutate(household_power_consumption, 
                                      datetime = paste(Date, Time))

household_power_consumption$datetime <- strptime(
    household_power_consumption$datetime, "%Y-%m-%d %H:%M:%S")

# Plot 1 ------------------------------------------------------------------

png(file = "plot1.png", bg = "transparent", width = 480, height = 480)

with(household_power_consumption, hist(
    Global_active_power, col = "red", main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)"))

dev.off()

# end ---------------------------------------------------------------------

