#Step 1 -  Download and unzip
#Download the zip file  and store in the "file" object. Unzip the file and store in the working directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "downloaded_data.zip"
download.file(url, file)
unzip(file, exdir = ".")

#Step 2 - Read data
EPC_data<-read.table("household_power_consumption.txt",
	                          stringsAsFactors=FALSE,
	                          sep = ";",
	                          header=FALSE,
	                          col.names=c("Date",
	                                       "Time",
	                                       "Global_active_power",
	                                       "Global_reactive_power",
	                                       "Voltage",
	                                       "Global_intensity",
                                         "Sub_metering_1",
                                         "Sub_metering_2",
	                                       "Sub_metering_3"),
	                          dec=".",
	                          skip = 66637,
	                          nrows = 2880
	                          )

EPC_data[,1]<-as.Date(EPC_data[,1],
                      format="%d/%m/%Y"
                      )
#Step 3 - Create a plot
png(file = "plot1.png",
    width = 480,
    height = 480,
    units = "px"
    )
hist(EPC_data[,3],col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
     )
dev.off()
