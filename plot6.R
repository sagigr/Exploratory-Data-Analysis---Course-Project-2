## Reading the data
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}
## Transforming data
data<-transform(NEI,type=factor(type),year=factor(year))
twocity<-data[data$fips=="24510"|data$fips=="06037",]
vehicles<-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicles)<-"SCC"
data2<-merge(vehicles,twocity,by="SCC")
data2$city[data2$fips=="24510"]<-"Baltimore"
data2$city[data2$fips=="06037"]<-"LA"
## Creating the png file
png("plot6.png", width=480, height=480)
## Creating the plot 6
library("ggplot2")
plotdata<-ddply(data2,.(year,city),summarize,sum=sum(Emissions))
ggpl<-ggplot(plotdata,aes(year,sum))
ggpl+geom_point(aes(color=city),size=4)+labs(title="PM2.5 Emission from motor vehicle sources",
 y="total PM2.5 emission each year")

print(ggpl)

dev.off()
