library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI,SCC, by = "SCC")
vehicle <- grepl("vehicle", NEISCC$Short.Name, ignore.case = TRUE)
vehicle1 <- NEISCC[vehicle, ]
pm25_BC_vehicle <- subset(vehicle1, fips == "24510")
pm25_BC_Vehicle_Total <- ddply(pm25_BC_vehicle, .(year), 
                               summarize,Emissions = sum(Emissions))
png("plot5.png", width=480, height=480)
g <- ggplot(pm25_BC_Vehicle_Total, aes(factor(year), Emissions))
g <- g + geom_bar(fill = "blue", stat = "identity", width = .25) + 
        ylab(expression("PM"[2.5]*"Emissions(tons)")) + xlab("year") + 
        ggtitle("Baltimore City Motor Vehicle Emissions")
print(g)
dev.off()

