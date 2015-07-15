## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}
## Subsetting NEI data by Baltimore's fip
baltimore<-subset(NEI, NEI$fips==24510)
##Summing emissions per year
totalBaltimore<-tapply(baltimore$Emissions, INDEX=baltimore$year, sum)
## Creating the plot 2
barplot(totalBaltimore, main="Total Emissions in Baltimore, MD by Year", xlab="Year", ylab="Emissions")
## Saving to file

