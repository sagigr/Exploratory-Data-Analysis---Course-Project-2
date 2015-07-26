## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
        NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./Source_Classification_Code.rds")
}
## Subsetting the data by Baltimore City (BC)
BCEmissions <-subset(NEI, fips==24510)
## Aggregating the Baltimore City (BC) emissions from motor vehicle sources by years
AggBCEmisiions <- aggregate(Emissions ~ year, data=BCEmissions, FUN=sum)
## Creating the png file
png("plot3.png",width=600, height=480)
## Creating the Plot 3
library(ggplot2)
TotalBCEmissions <- ggplot(BCEmissions, aes(factor(year),Emissions,fill=type)) + geom_bar(stat="identity") +
theme_bw() + guides(fill=FALSE)+ facet_grid(.~type,scales = "free",space="free") + labs(x="Year", y="Emissions (Tons)") + 
labs(title=expression("Total PM"[2.5]*" Emissions, Baltimore City, MD by Types"))
print(TotalBCEmissions)
dev.off()
