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
# Summarize dataset for 4th question -----------------------------------------------------
# ----------------------------------------------------------------------------------------
q4data <-  ddply(
     subset(mydata,grepl("^Fuel Comb -",mydata$EI.Sector) 
            & grepl("- Coal$",mydata$EI.Sector))
     , .(year,type), summarize
     , var_sum = sum(Emissions,na.rm = TRUE)
)

# ---------------------------------------------------
# Create plot for 4th question using ggplot system --
# --------------------------------------------------- 
png(filename = "q4plot.png"
    ,height =  480
    ,width =  800
)
qplot(year,var_sum,data = q4data
      ,geom = c("point","smooth")
      ,method = "lm"
      ,main = "National Coal Cumbustion Sources"
      ,xlab = "Year"
      ,ylab = "Emmissions (tons)")

dev.off()
#_________________________________________________________________________________________
