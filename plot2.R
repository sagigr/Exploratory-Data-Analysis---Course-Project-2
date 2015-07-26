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
SumBCEmissions <-tapply(BCEmissions$Emissions, INDEX=BCEmissions$year, sum)
## Creating the Plot 2
barplot(SumBCEmissions, main=expression('Total PM'[2.5]*' Emissions in Baltimore City, MD by Year'), xlab="Year", ylab="Emissions (Tons)")
## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
