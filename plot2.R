# plot2.R
# Submission for Project 1 of Exploratory Data Analysis
# Reads data from a filtered file and generates a line plot for Global Active Power Vs datetime
# Also creates the filtered file if it does not exist
# The filtered file is used to avoid memory issues resulting from loading a very large
# file into memory

# **  Assumes that the file household_power_consumption.txt has been downloaded
#    and is available in the current working directory  **

# Check if the filtered text file exists, 
# create it, if it does not exist
if(!file.exists("power_consumption_filtered.txt")){
	file_in <- file("household_power_consumption.txt", "r")
	file_out <- file("power_consumption_filtered.txt", "a")
	x <- readLines(file_in, n=1) #  Read the first line of the source file which is the header
	writeLines(x, file_out) #  Write the header into the target file
	while(length(x)){
		ind <- grep("^[0-2]/2/2007",x) #  Look for lines that have 1/2/2007 or 2/2/2007 in them
		if(length(ind)) writeLines(x[ind], file_out) #  Write the filtered lines into the file
		x <- readLines(file_in, n=200000)
		}
	close(file_in)
	close(file_out)
}

# Read the filtered file into a dataframe
hpc <- read.csv("power_consumption_filtered.txt", sep=";", as.is= TRUE)
# Open the graphic device
png(filename="plot2.png", width=480, height=480)
# Create plot for Global Active Power - Strptime to convert the date and time into a date object
plot(strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S"), hpc$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
# Close the device
dev.off()