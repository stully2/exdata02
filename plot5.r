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
# Summarize dataset for 5th question -----------------------------------------------------
# ----------------------------------------------------------------------------------------
q5data <-  ddply(
     subset(mydata,Data.Category == "Onroad" & fips == "24510")
     , .(year), summarize
     , var_sum = sum(Emissions,na.rm = TRUE)
)

# ---------------------------------------------------
# Create plot for 5th question using ggplot system --
# --------------------------------------------------- 
png(filename = "q5plot.png"
    ,height =  480
    ,width =  800
)
qplot(year,var_sum,data = q5data
      ,geom = c("point","smooth")
      ,method = "lm"
      ,main = "Baltimore Onroad Sources"
      ,xlab = "Year"
      ,ylab = "Emmissions (tons)")

dev.off()
#_________________________________________________________________________________________
