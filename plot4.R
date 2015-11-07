#Step 0  -  Load necessary packages
	require("lubridate")
#Step 1 -  Download and unzip
#Download the zip file  and store in the "file" object. Unzip the file and store in the working directory
	
	url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	file <- "downloaded_data.zip"
	download.file(url, file)
	unzip(file, exdir = ".")
	

#Step 2 - Read and subset features
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

Sys.setlocale("LC_TIME", "US") 
EPC_data_time<-as.data.frame(dmy_hms(paste(EPC_data[,1],
                                           EPC_data[,2])
                                    )
                            )
#Step 3 - Create a plot


png(file = "plot4.png",
   width = 480,
   height = 480,
   units = "px"
   )

par(mfcol = c(2, 2))

# plot 1
plot(x=EPC_data_time[,1],
     y=EPC_data[,3],
     pch='.',
     ylab = "Global Active Power",
     xlab=""
)
lines(x=EPC_data_time[,1],
      y=EPC_data[,3]
)



#plot 2
plot(x=EPC_data_time[,1],
     y=EPC_data[,7],
     ylab = "Energy sub metering",
     xlab = "",
     type = "n",
     col = "black"
)
lines(x=EPC_data_time[,1],
      y=EPC_data[,7],
      col = "black"
)
lines(x=EPC_data_time[,1],
      y=EPC_data[,8],
      col = "red"
)
lines(x=EPC_data_time[,1],
      y=EPC_data[,9],
      col = "blue"
)

legend("topright",
       lwd = c(1,1,1),
       col = c("black", "red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)


# plot 3
plot(x=EPC_data_time[,1],
     y=EPC_data[,5],
     pch='.',
     ylab = "Voltage",
     xlab="datetime"
)
lines(x=EPC_data_time[,1],
      y=EPC_data[,5]
)

# plot 4
plot(x=EPC_data_time[,1],
     y=EPC_data[,4],
     pch='.',
     ylab = "Global_reactive_power",
     xlab="datetime"
)
lines(x=EPC_data_time[,1],
      y=EPC_data[,4]
)


dev.off()


