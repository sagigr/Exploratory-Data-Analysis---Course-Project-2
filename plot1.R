## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}
totalNEI<-tapply(NEI$Emissions, INDEX=NEI$year, sum)
barplot(totalNEI, main = "Total Emissions by Year", xlab="Year", ylab="Emissions")
## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
