library(plumber)

#* @apiTitle Clase sobre el uso de plumber
#* @apiDescription En este api se implementaran carios 
#*  endpoint que nos serviran para aprender el uso de plumber

#* Eco del input
#* @param msg Mensaje que vamos a repetir
#* @get /echo


function(msg=""){
  list(msg = paste0("El mensaje es: ", msg))
}

#* Historama distribucion Normal
#* @serializer png
#* @param n total de numero aleatorios
#* @param bins numero de bing
#* @get /plot

function(n=100, bins = 15){
  rand <- rnorm(as.numeric(n))
  hist(rand, breaks = as.numeric(bins))
}


#* suma de dos parametros
#* @serializer unboxedJSON
#* @param x primer numero
#* @param y segundo numero
#* @get /suma 

function(x='1', y='1' ){
  x <- as.numeric(x)
  y <- as.numeric(y)
  list('Primer numero' = x,
       'Segundo numero' = y,
       'output' = x + y)
}

#* Ejemplo de serializacion de csv
#* @serializer csv
#* @param n numero de filas
#* @get /data

function(n='100'){
  head(mtcars, as.numeric(n))
}