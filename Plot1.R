library(plyr)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pm25_total <- ddply(NEI, .(year), summarize,Emissions = sum(Emissions))
print(pm25_total)
Emissions <- pm25_total$Emissions
year<- pm25_total$year
pct <- round(Emissions/sum(Emissions)*100)
year <- paste(year, pct)
year <- paste(year, "%", sep = "")
png("plot1.png", width=480, height=480)
pie(Emissions,labels = year, col = rainbow(length(year)), 
    main = "Pie Chart of Total Pollutants by year")
dev.off()