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
#Answer to Question 5
NEISCC <- merge(NEI, SCC, by="SCC")

sub3 <- subset(NEISCC, fips == "24510" & type == "ON-ROAD")#get subset of only baltimore city and emmission on road
CarEmission <- with(sub3, aggregate(Emissions, by = list(EI.Sector,year), sum)) 
head(CarEmission)# check for column names
colnames(CarEmission) <- c("EI.Sector", "year", "Emissions")
png(filename = "plot5.png", width = 500, height = 500, units = "px")

qplot(year, Emissions, data = sub3,
        geom = "point", ylab = "Total Emissions", 
      xlab = "Year", main = "Total Baltimore Car Emissions by EI.Sector")
# Close the PNG device
dev.off()
