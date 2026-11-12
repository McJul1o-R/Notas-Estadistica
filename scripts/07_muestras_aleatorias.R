# Calcular los valores reales

mediapob = mean(preciosMSFT)
mediapob

varianzapob = var(preciosMSFT)
varianzapob

# Utilizar una muestra de 200 datos.

n = 200
aleatorio = sample(1:711, n, replace = F)
muestra = preciosMSFT[aleatorio]

