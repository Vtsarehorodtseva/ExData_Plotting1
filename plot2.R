library(readr)
library(dplyr)
library(lubridate)

#create plots folder
if (dir.exists("plots") == FALSE) {
  dir.create("plots")
}

#data load
data_path <- list.files(pattern = "household_power_consumption.txt",
                        recursive = TRUE,
                        ignore.case = TRUE)

data <- read_delim(data_path, delim = ";")

#date subset
data_feb <- data %>% 
  filter(dmy(Date) %within% interval(ymd("2007-02-01"), ymd("2007-02-02"))) %>%
  #concatenating date and time
  mutate(f_date = paste(Date, Time, sep = " "))

#converting to POSIXct date format
data_feb$f_date <- dmy_hms(data_feb$f_date)

#linear ploting 
plot(data_feb$f_date, data_feb$Global_active_power, 
     type = "l", xlab = "", ylab = "Global Active Power")

#saving png file in plots folder
dev.copy(png, file = "plots/plot2.png")
dev.off()