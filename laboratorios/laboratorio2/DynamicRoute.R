library(plumber)
library(dplyr)
library(lubridate)


data <- read.csv("s&p.csv", sep = ",")
data[,1] <- as.Date.character(data[,1], format = "%d/%m/%y")
users <- data.frame(
  uid=c(12,13,15,40,23,54),
  username=c("carlos", "mario","marcela", "daniel", "lorena", "javier")
)

#* Lookup a user
#* @get /users/<id>
function(id){
  subset(users, uid %in% id)
}

#* @get /inicio/<from>/final/<to>
function(from, to){
  # Do something with the `from` and `to` variables...
  from <- ymd(from)
  to <- ymd(to)
  subset(data, data$Fecha >= from & data$Fecha <= to)
}


#* @get /type_int/<id:int>
function(id){
  list(
    id = id,
    type = typeof(id),
    numero_mas_15 = id + 15
  )
}

#* @get /type_bool/<id:bool>
function(id){
  list(
    id = id,
    type = typeof(id),
    verdadero = (TRUE == id)
  )
}


#* @get /type_logical/<id:logical>
function(id){
  list(
    id = id,
    type = typeof(id),
    verdadero = (TRUE == id)
  )
}

#* @get /type_numeric/<id:numeric>
function(id){
  list(
    id = id,
    type = typeof(id),
    numero_menos_15 = id - 15
    
  )
}

#* @get /type_double/<id:double>
function(id){
  list(
    id = id,
    type = typeof(id),
    numero_mas_15_menos_3_mas_4 = id + 15 - 3 + 4
    
  )
}
