# Download files

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "./exploratory")
if(!exists("NEI")){
        NEI <- readRDS("./exploratory/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./exploratory/Source_Classification_Code.rds")
}
#Answer to Question 1

total.emissions <- with(NEI, aggregate(Emissions, by = list(year), sum))
png(filename = "plot1.png", width = 500, height = 500, units = "px") # open PNG device
plot(total.emissions, type = "l", pch = 19, col = "red", ylab = "Emissions", 
     xlab = "Year", main = "Total Emissions from PM2.5 in US by year")
# Close the PNG device
dev.off()
