refrescos = c("Coke_Classic", "Pepsi", "Sprite", "Dr.Pepper")
set.seed(1548)
datos = sample(refrescos, 30, replace = T)
frecuencias = table(datos)
n = length(datos)
FR = frecuencias/n
FP = 100*FR
pie(FP, labels = names(FP))

# Argumentos estéticos

porcentaje = paste0(names(FP), sep = ": ",round(FP,2), "%")
pie(FP,labels = porcentaje)
