## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
        NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./Source_Classification_Code.rds")
}
## Subsetting the data by Baltimore City (BC) emissions from motor vehicle sources
BCEmissions <-subset(NEI, fips==24510 & type=="ON-ROAD")
## Aggregating the Baltimore City (BC) emissions from motor vehicle sources by years
AggBCEmisiions <- aggregate(Emissions ~ year, data=BCEmissions, FUN=sum)
## Creating the png file
png("plot5.png",width=640,height=520)
## Creating the Plot 5
library(ggplot2)
VechicleEmissions <- ggplot(AggBCEmisiions, aes(factor(year), Emissions)) + geom_bar(stat="identity", fill="grey") +
theme_bw() + guides(fill=FALSE)+ labs(x="Year", y="Emissions (Tons)") +
labs(title="Emissions from Motor Vehicle Sources in Baltimore City, MD, 1999–2008")
print(VechicleEmissions)
dev.off()
