library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI,SCC, by = "SCC")
vehicle <- grepl("vehicle", NEISCC$Short.Name, ignore.case = TRUE)
vehicle1 <- NEISCC[vehicle, ]
pm25_vehicle <- subset(vehicle1, fips == "24510" | fips =="06037")
pm25_Vehicle_Total <- ddply(pm25_vehicle, .(year,fips), 
                               summarize,Emissions = sum(Emissions))

png("plot6.png", width=720, height=480)
g <- ggplot(pm25_Vehicle_Total, aes(factor(year), Emissions))
g <- g + geom_bar(fill = "blue", stat = "identity", width = .25) + coord_flip() +
        facet_grid(. ~ fips) + ylab(expression("PM"[2.5]*"Emissions(tons)")) + 
        xlab("year") + ggtitle("Baltimore City (fips = 24510) and Los Angeles County
                               (fips = 06037) Motor Vehicle Emissions")
print(g)
dev.off()
