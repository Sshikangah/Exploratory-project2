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
# Answer to Question 4
NEISCC <- merge(NEI, SCC, by="SCC")

CoalNEISCC <- grepl("Coal+", NEISCC$Short.Name, ignore.case=TRUE) # get logical selection of only short.names with Coal word
sub2 <- NEISCC[CoalNEISCC, ]
CoalEmission <- with(sub2, aggregate(Emissions, by = list(type, year), sum)) 
head(CoalEmission)# check for column names
colnames(CoalEmission) <- c("Type", "year", "Emissions")
png(filename = "plot4.png", width = 500, height = 500, units = "px")
g = ggplot(CoalEmission, aes(factor(year), Emissions))
g + geom_point(color = "blue") + geom_line(color = "red") + labs(x = "Year") + 
        labs(y = "Total Coal Emissions") + labs(title = "Coal Emissions in the US")
# Close the PNG device
dev.off()

