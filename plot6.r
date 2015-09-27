if (!exists("origpath")){
     origpath <- getwd()
     setwd(paste(origpath,"exdata02",sep = "/"))}

# Collect Data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
mydata <- merge(nei,scc,by = "SCC", x.all = TRUE)
rm("nei","scc")

# Load Libraries
library(plyr)
library(ggplot2)


# ----------------------------------------------------------------------------------------
# Summarize dataset for 6th question -----------------------------------------------------
# ----------------------------------------------------------------------------------------
q6data <-  ddply(
     subset(mydata,Data.Category == "Onroad" & (fips == "24510" | fips == "06037"))
     , .(year,fips), summarize
     , var_sum = sum(Emissions,na.rm = TRUE)
)
q6data$fips <- revalue(q6data$fips,c("24510"="Baltimore","06037"="Los Angeles"))

# ---------------------------------------------------
# Create plot for 6th question using ggplot system --
# --------------------------------------------------- 
png(filename = "q6plot.png"
    ,height =  480
    ,width =  800
)
qplot(year,var_sum,data = q6data
      ,facets = .~fips
      ,geom = c("point","smooth")
      ,method = "lm"
      ,main = "Baltimore vs Los AngelesOnroad Sources"
      ,xlab = "Year"
      ,ylab = "Emmissions (tons)")

dev.off()
#_________________________________________________________________________________________
