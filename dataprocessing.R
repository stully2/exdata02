nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
mydata <- merge(nei,scc,by = "SCC", x.all = TRUE)
rm("nei","scc")
library(plyr)
summary01 <- ddply(mydata,year)


q1data <- ddply(
              mydata
              , .(year), summarize
                , var_sum = sum(Emissions,na.rm = TRUE))

png(filename = "q1plot.png",height =  480,width =  800)
with(q1data, plot(year,var_sum,type = "l"))
dev.off()

qa2data <-  ddply(
              subset(mydata,fips == "24510")
              , .(year), summarize
              , var_sum = sum(Emissions,na.rm = TRUE))