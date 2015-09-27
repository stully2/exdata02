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
# Summarize dataset for 3rd question -----------------------------------------------------
# ----------------------------------------------------------------------------------------
q3data <-  ddply(
     subset(mydata,fips == "24510")
     , .(year,type), summarize
     , var_sum = sum(Emissions,na.rm = TRUE)
)

# ---------------------------------------------------
# Create plot for 3rd question using ggplot system --
# --------------------------------------------------- 
png(filename = "q3plot.png"
    ,height =  480
    ,width =  800
)
qplot(year,var_sum,data = q3data
      ,facets = .~type
      ,geom = c("point","smooth")
      ,method = "lm")
dev.off()
#_________________________________________________________________________________________


