library(rnaturalearth) #mapa de toda la tierra, poligonos. 
library(sp)
library(wbstats) # estadisticas del banco mundial
library(DT)
library(leaflet)
library(dplyr)
library(flexdashboard)

map <- ne_countries()
# plot(map)
# View(map@data)

indicator <-
  wb_search(pattern = "pollution")

d <-
  wb_data(indicator = "EN.ATM.PM25.MC.M3",
              start_date = 2016, end_date = 2016)
names(d)

names(d)[5] <- 'value'



map$PM2.5 <- d[match(map$iso_a3,d$iso3c),'value'] %>% pull(value)

DT::datatable(map@data[c("iso_a3","name","PM2.5")], 
              rownames = FALSE, options = list(pageLength = 10)) # muestra la info, por "paginas"


# seq(0, max(map$PM2.5, na.rm = TRUE) empezar en 0 hasta el más grande
# como dividire los colores según los valores que tengo
pal <- colorBin(palette = "viridis", domain = map$PM2.5, 
                bins = seq(0, max(map$PM2.5, na.rm = TRUE), by = 10))
#etiquetas del mapa. pais y valor 

map$labels <- 
  paste0("<strong> Pais: </strong>",
         map$name, "<br/>",
         "<strong> PM2.5: </strong>",
         round(map$PM2.5,2), "<br/>") %>% lapply(htmltools::HTML) #aplico html a cada linea

leaflet(map) %>%
  addTiles() %>%
    setView(lng = 0, lat = 30, zoom = 2) %>% 
    addPolygons(fillColor = ~pal(PM2.5), 
                color = "white",
                fillOpacity = 0.7,
                label = ~labels,
                highlight = highlightOptions(color = "black",
                                             bringToFront = TRUE)
                ) %>%
  addLegend(pal=pal,
            values = ~PM2.5,
            opacity = 0.7,
            title = "PM2.5")

