## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}
##  Creating the plot 1
totalNEI<-tapply(NEI$Emissions, INDEX=NEI$year, sum)
barplot(totalNEI, main = expression('Total PM'[2.5]*' Emissions by Year'), xlab="Year", ylab="Emissions")
## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)

dev.off()
