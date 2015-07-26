## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
        NEI <- readRDS("./summarySCC_PM25.rds")
        NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
}
if(!exists("SCC")){
        SCC <- readRDS("./Source_Classification_Code.rds")
}
## Subsetting the data by Baltimore City (BC) and Los Angeles County (LAC) emissions from motor vehicle sources
BCEmissions <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
LACEmissions <- subset(NEI, fips == 06037 & type == 'ON-ROAD')
## Aggregating the Baltimore City (BC) and Los Angeles County (LAC) emissions from motor vehicle sources
AggBCEmissions <- aggregate(BCEmissions[, 'Emissions'], by = list(BCEmissions$year), FUN=sum)
colnames(AggBCEmissions) <- c('Year', 'Emissions')
AggBCEmissions$City <- paste(rep('Baltimore City', 4))
AggLACEmissions <- aggregate(LACEmissions[, 'Emissions'], by = list(LACEmissions$year), FUN=sum)
colnames(AggLACEmissions) <- c('Year', 'Emissions')
AggLACEmissions$City <- paste(rep('Los Angeles County', 4))
BCLAC <- as.data.frame(rbind(AggBCEmissions, AggLACEmissions))
## Creating the png file
png("plot6.png",width=640,height=520)
## Creating the Plot 6
library(ggplot2)
BCLACEmissions <- ggplot(BCLAC, aes(factor(year), Emissions)) + geom_bar(aes(fill = year), stat="identity") +
theme(legend.position = 'none') + guides(fill=FALSE)+ facet_grid(. ~ City) + 
geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1)) + labs(x="Year", y="Emissions (Tons)") +
labs(title="Emissions from Motor Vehicle Sources in Baltimore City vs. Los Angeles County")
print(BCLACEmissions)
dev.off()

#ggplot(data = DF, aes(x = year, y = Emissions)) + 
#geom_bar(aes(fill = year),stat = "identity") + 
#guides(fill = F) + 
#ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
#ylab(expression('PM'[2.5])) + 
#xlab('Year') + 
#theme(legend.position = 'none') + 
#facet_grid(. ~ City) + 
#geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
#dev.off()
