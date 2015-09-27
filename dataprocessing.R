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
