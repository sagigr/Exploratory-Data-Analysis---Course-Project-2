## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}
##
sources <- SCC[grepl("On-Road", SCC$EI.Sector),]
sources <- sources$SCC
data <- NEI[NEI$SCC %in% sources,]
data <- NEI[NEI$fips %in% c("24510", "06037"),]
data <- aggregate(Emissions ~ year + fips, data=data, sum)
## Creating the png file
png("plot6.png",width=640, height=480)
## Creating the plot 6
library(ggplot2)
ggpl <- qplot(year, Emissions, color=fips, data=data, geom="path",
main="Emissions From Vehicle Related Sources in Baltimore and Los Angeles County", xlab="Year", ylab="Emissions", fill=fips)
#ggsave(ggpl, file="plot6.png", width=10, height=5)

print(ggpl)

dev.off()
