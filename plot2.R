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
# Answer to Question 2

sub1 <- subset(NEI, fips == "24510")
baltimore <- with(sub1, aggregate(Emissions, by = list(year), sum))
colnames(baltimore) <- c("year", "Emissions")
rng <- range(baltimore)#set range to fit 1862.282 to 3274.180
png(filename = "plot2.png", width = 500, height = 500, units = "px")
plot(baltimore, type = "l", pch = 19, col = "wheat", ylim = rng,  ylab = "Emissions", xlab = "Year", main = "Total Baltimore Emissions by year")
# Close the PNG device
dev.off()
