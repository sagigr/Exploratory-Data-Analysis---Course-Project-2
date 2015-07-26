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
## Summing Baltimore emissions by year
SumBCEmissions <- aggregate(Emissions ~ year, BCEmissions,sum)
## Creating the png file
png("plot3.png",width=600, height=480)
## Creating the Plot 3
library(ggplot2)
ggpl <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City, MD 1999-2008 by Source Type"))
dev.off()
