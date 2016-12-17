library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pm25_BC <- subset(NEI, fips == "24510")
pm25_BC_type <- ddply(pm25_BC, .(type,year), summarize,Emissions = 
                              sum(Emissions))
pm25_BC_type1 <- subset(pm25_BC_type, type == "NON-ROAD")
pm25_BC_type2 <- subset(pm25_BC_type, type == "NONPOINT")
pm25_BC_type3 <- subset(pm25_BC_type, type == "ON-ROAD")
pm25_BC_type4 <- subset(pm25_BC_type, type == "POINT")

png("plot3.png", width=960, height=480)
g <- ggplot(pm25_BC_type, aes(factor(year), Emissions))
g <- g + geom_bar(fill = "blue", stat = "identity", width = .25) + coord_flip() + 
        facet_grid(. ~ type) + ylab(expression("PM"[2.5]*"Emissions(tons)")) + 
        xlab("year") + ggtitle("Baltimore City PM 2.5 Emissions by type")
print(g)
dev.off()
