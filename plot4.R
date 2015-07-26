## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
        NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./Source_Classification_Code.rds")
}
## Finding coal combustion-related sources (CCRS)
isCCRS <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
CCRS <- SCC[isCCRS,]
## Finding emissions from coal combustion-related sources
CCRSE <- NEI[(NEI$SCC %in% CCRS$SCC), ]
## Groupping by years
CCRSEY <- aggregate(Emissions ~ year, data=CCRSE, FUN=sum)
## Creating the png file
png("plot4.png",width=600,height=480)
## Creating the Plot 4
library(ggplot2)
CoalEmissions <- ggplot(CCRSEY/10^3, aes(x=factor(year), y=Emissions)) + 
geom_bar(stat="identity") + xlab("Year") + ylab("Emissions (kTons)") + 
ggtitle("Emissions from Coal Combustion-Related Sources Across the United States, 1999–2008")
print(CoalEmissions)
dev.off()
