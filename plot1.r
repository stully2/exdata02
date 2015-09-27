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
# Summarize dataset for 1st question -----------------------------------------------------
# ----------------------------------------------------------------------------------------
q1data <- ddply(
     mydata
     , .(year), summarize
     , var_sum = sum(Emissions,na.rm = TRUE)
)

# ---------------------------------------------------
# Create plot for 1st question using base system ----
# ---------------------------------------------------     
png(filename = "q1plot.png"
    ,height =  480
    ,width =  800)

fit <- lm(q1data$var_sum ~ q1data$year)

plot(q1data$year
     ,q1data$var_sum
     ,pch = 20
     ,main = "Nationwide Particulate Matter"
     ,xlab = "Year"
     ,ylab = "Emmissions (tons)"
)
abline(fit, col = "red")

dev.off()
#_________________________________________________________________________________________
