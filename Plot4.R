library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI,SCC, by = "SCC")
sub1<- grepl("coal",NEISCC$Short.Name, ignore.case = TRUE)
sub2<- NEISCC[sub1, ]
pm25_Coal_Total <- ddply(sub2, .(year), summarize,Emissions = sum(Emissions))
png("plot4.png", width=480, height=480)
g <- ggplot(pm25_Coal_Total, aes(factor(year), Emissions))
g <- g + geom_bar(fill = "blue", stat = "identity", width = .25) + 
        ylab(expression("PM"[2.5]*"Emissions(tons)")) + xlab("year") + 
        ggtitle("Total US Emissions from Coal Sources")
print(g)
dev.off()
