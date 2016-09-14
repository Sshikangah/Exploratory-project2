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
# Answer to Question 3
library(ggplot2)
sub1 <- subset(NEI, fips == "24510")
baltimore <- with(sub1, aggregate(Emissions, by = list(type, year), sum))
colnames(baltimore) <- c("Type", "year", "Emissions")
#head(baltimore) check first 6 rows
png(filename='plot3.png', width=500, height=500, units='px')# open png
qplot(year, Emissions, data = baltimore,
      color = Type, geom = c("point", "line"), ylab = "Total Emissions", 
      xlab = "Year", main = "Total Baltimore Emissions by Type")

# Close the PNG device 
dev.off()
