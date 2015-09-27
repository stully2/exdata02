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
# Summarize dataset for 2nd question -----------------------------------------------------
# ----------------------------------------------------------------------------------------
q2data <-  ddply(
     subset(mydata,fips == "24510")
     , .(year), summarize
     , var_sum = sum(Emissions,na.rm = TRUE)
)

# ---------------------------------------------------
# Create plot for 2nd question using base system ----
# --------------------------------------------------- 
png(filename = "q2plot.png"
    ,height =  480
    ,width =  800)

fit <- lm(q2data$var_sum ~ q2data$year)

plot(q2data$year
     ,q2data$var_sum
     ,pch = 20
     ,main = "Baltimore Particulate Matter"
     ,xlab = "Year"
     ,ylab = "Emmissions (tons)"
)
abline(fit, col = "red")


dev.off()
#_________________________________________________________________________________________
