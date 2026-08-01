refrescos = c("Coke_Classic", "Pepsi", "Sprite", "Dr.Pepper")
set.seed(1548)
datos = sample(refrescos, 30, replace = T)
frecuencias = table(datos)
resumen
barplot(frecuencias)