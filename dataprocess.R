##load required libraries
library(dplyr)
library(data.table)
library(DT)

##read data
veichles <- read.csv("vehicles.csv")


## extract variables we want to use in the dataset 
## as concise as possible
##feScore is EPA Fuel Economy Score
myvars <-c("cylinders","displ","drive","feScore","fuelCost08","make","model","year","youSaveSpend")
newdata <-veichles[myvars]
newdata <- newdata[newdata$year>=2013,]

##remove all na values in the dataset
newdata <- newdata[complete.cases(newdata),]


##filter dataset based on year, fecore, make of car, and Drive axle drive
#' 
#' @param dt data.table
#' @param Year
#' @param minEPA
#' @param maxEPA
#' @param carmake
#' @param Drive
#' @return data.table
#'
dataByAll <- function(dt, Year, minEPA,
                           maxEPA,carmake,Drive) {
  result <- dt %>% filter(year ==Year, feScore >= minEPA, feScore <= maxEPA, make %in% carmake, drive %in% Drive) 
  return(result)
}

##filter dataset based on year
#' 
#' @param dt data.table
#' @param Year
#' @return data.table
#'
dataByYear <- function(dt,Year) {
  result <- dt %>% filter(year == Year) 
  return(result)
}


##filter dataset based on year, fecore, make of car
#' 
#' @param dt data.table
#' @param Year
#' @param minEPA
#' @param maxEPA
#' @param carmake
#' @return data.table
#'
dataByMake <- function(dt, Year, minEPA,
                      maxEPA,carmake) {
  result <- dt %>% filter(year ==Year, feScore >= minEPA, feScore <= maxEPA, make %in% carmake) 
  return(result)
}

##filter dataset based on year, fecore
#' 
#' @param dt data.table
#' @param Year
#' @param minEPA
#' @param maxEPA
#' @return data.table
#'
dataByEPA <- function(dt, Year, minEPA,
                      maxEPA) {
  result <- dt %>% filter(year ==Year, feScore >= minEPA, feScore <= maxEPA) 
  return(result)
}

##Aggregate data based on youSaveSpend,drive,make,model,year
#' 
#' @param dt data.table
#' @param Year
#' @param minEPA
#' @param maxEPA
#' @param carmake
#' @return data.table

aggDataByMake <- function(dt,Year,minEPA,maxEPA,carmake){
  temp1 <-dataByMake(dt, Year, minEPA,maxEPA,carmake)
  temp21 <- aggregate(youSaveSpend~drive+make+model+year,temp1,sum)
  return(temp21)
}


