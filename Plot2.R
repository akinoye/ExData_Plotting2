library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pm25_BC <- subset(NEI, fips == "24510")
pm25_BC_Total <- ddply(pm25_BC, .(year), summarize,Emissions = sum(Emissions))
png("plot2.png", width=480, height=480)
plot(pm25_BC_Total$year, pm25_BC_Total$Emissions, type = "o", xlab = "Year", 
     ylab = "Emissions (tons)", main = "Baltimore City pm2.5 Emissions")
dev.off()