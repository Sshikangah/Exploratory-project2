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
#Answer to Question 6
NEISCC <- merge(NEI, SCC, by="SCC")
#get subset for Los Angeles County CA and baltimore city Maryland emmission on road

sub4 <- NEISCC[(NEISCC$fips == "24510" & NEISCC$type == "ON-ROAD") | (NEISCC$fips == "06037" & NEISCC$type == "ON-ROAD"),]

CarEmission <- with(sub4, aggregate(Emissions, by = list(fips,year), sum)) 
head(CarEmission)# check for column names

colnames(CarEmission) <- c("fips", "year", "Emissions")
CarEmission <- with(sub4, aggregate(Emissions, by = list(EI.Sector,year), sum)) 
head(CarEmission)# check for column names
colnames(CarEmission) <- c("EI.Sector", "year", "Emissions")

png(filename = "plot6.png", width = 800, height = 500, units = "px")# open device
qplot(year, Emissions, data =sub4, facets = .~fips,  geom = "point", ylab = "Total Emissions", 
      xlab = "Year", main = "Compare Baltimore and Los Angeles county Car Emissions")


# Close the PNG device
dev.off()
