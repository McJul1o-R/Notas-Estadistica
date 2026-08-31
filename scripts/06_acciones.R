# Define las fechas iniciales y finales.

inicio = "2024-01-01"
final = "2026-07-31"

# Activa la libreria 

library(quantmod)

# Extrae el precio de la acción que requieras. 
# RECUERDA QUE NECESITAS el Tiker de la página de yahoo finanzas.

MSFT = getSymbols("MSFT", 
                  from = inicio, 
                  to = final, 
                  src = "yahoo", 
                  auto.assign = F)

# Revisa el archivo, viendo los primeros elementos.

head(MSFT)

# Para mejor manipulación, podemos convertir los precios a un vector de precios. 
# Recuerda siempre elegir la columna que diga Adjusted. 

preciosMSFT = as.vector(MSFT$MSFT.Adjusted)

# Con este objeto, calcula lo que necesites.