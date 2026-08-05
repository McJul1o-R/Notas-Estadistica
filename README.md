# CURSO DE ESTADÍSTICA

En este repositorio encontraremos ejercicios y ejemplos que se 
realizarán por Rstudio. Para instalar de manera adecuada estas herramientas,
seguiremos las siguientes ligas en ese orden:

**Descargar e instalar paquetería R:**

https://cran.itam.mx/

**Descargar e instalar paquetería LaTeX**

https://miktex.org/download

**Descargar e instalar Rstudio**

https://posit.co/downloads

Si seguimos estos pasos, obtenemos los requisitos mínimos para visualizar y ejecutar
las herramientas matemáticas que utilizaremos. 

Cabe mencionar que si utilizan GitHub, pueden vincular el Rstudio con Git para subir
sus proyectos y tareas. Realizar esto queda fuera de este curso, por lo que invitamos 
a los lectores interesados investigar más a fondo sobre esto.

## Estadística descriptiva

Empecemos con los conceptos básicos que utilizaremos durante este curso.

El conjunto completo de datos que queremos analizar recibe el nombre de **población**.
Por lo general, la población tiende a ser muy grande para analizarla completa, 
en particular por falta tiempo y/o presupuesto. 
En este caso, analizaremos un subconjunto significativo de la población, el cual se llamará
**muestra**.

Un **censo** es un instrumento que obtiene información de toda la problación.

Una **encuesta** es un instrumento que obtiene información de la muestra.

Un **parámetro** es una medición realizada en una población.

Un **estadístico** es una medición realizada en una muestra.

En esta sección nos concentramos en trabajar con estos últimos objetos. 

Cabe señalar que los estadísticos no son objetos desconocidos. En cursos y/o situaciónes anteriores
posiblemente realizarón el cálculo de los estadísticos más comunes, por ejemplo una proporción o probabilidad, promedio, varianza y desviación estándar.

Retomaremos la definición de estos estadísticos más adelante.

Antes de iniciar con los cálculos es importante reconocer los tipos de datos que trabajaremos.

Existen dos formas de clasificar a los datos. 

- Por su tipo.
- Por su nivel de medición.

### Clasificación por el tipo de datos

En esta clasificación tenemos dos grupos:

- **Datos categóricos, cualitativos o de atributo**
- **Datos numéricos o cuantitativos**

Los datos cualitativos son nombres o etiquetas que no representan un conteo o medición.

Los datos cuantitativos son números que representan conteos o mediciones.

### Ejemplos

Para datos cualitativos:

 - Partidos políticos de un país.
 - Color de pelo.
 - Marca de una calculadora.
 - Los números de una tarjeta de crédito.
 
Para datos cuantitativos:
 
 - Edades de personas
 - Número de autos en una ciudad.
 - Huevos que pone una gallina.
 - Litros de refresco que consume una ciudad.
 - Ventas diarias de una empresa.
 - Arena en una parque.

### Datos cuantitativos

Los datos cuantitativos tienen su propia clasificación:

- **Discretos:** datos que se pueden contar. Utilizan números naturales.
- **Continuos:** datos que no se pueden contar. Utilizan rangos de los números reales.

Esta nueva clasificación separa a los ejemplos anteriores de la siguiente manera:

Datos discretos:
 - Edades de personas
 - Número de autos en una ciudad.
 - Huevos que pone una gallina.
 
Datos continuos: 
 - Litros de refresco que consume una ciudad.
 - Ventas diarias de una empresa.
 - Arena en una parque.

Para finalizar esta parte, dejamos el siguiente ejercicio

*Determina el tipo de dato que representa la siguiente imagen*

![Playeras deportivas](imagenes/playeras.png)

### Clasificación por el nivel de medición

En esta clasificación, las características de los datos aumentan conforme vamos 
definiendo los niveles. 

1. **Nominal:** Los datos representan nombres y etiquetas, pero 
no tienen un orden.

2. **Ordinal:** Los datos representan etiquetan con orden, pero la resta de datos carece de sentido.

3. **Intervalo:** Los datos tienen orden y la resta tiene significado, pero no tienen valor inicial. 
Esto es, el cero no representa la falta del atributo.

4. **Razón:** Los datos tienen orden, la resta tiene significado y el cero si represetan ausencia del atributo.

Algunos ejemplos quedan clasificados como sigue:

- **Nominal**

  -Color de ojos.
  -Lugar de nacimiento.
  
- **Ordinal**

  -Nivel escolar (primari, secundaria, preparatoria)
  -Intensidad de color (leve, normal,fuerte)
  -Tallas de ropa (chica, mediana, grande)
  
- **Intervalo**

 -Temperatura de una ciudad.
 -Tiempo de elaboración de un proyecto.
 -Calificaciones exámenes.
 
- **Razón**

  -Velocidad de un auto.
  -Altura de un edificio.
  -Ventas de una empresa.
  
Finalizamos esta sección con un ejercicio

*Realiza un mapa conceptual sobre los tipos de datos y sus clasificaciones*

*Agrega ejemplos de cada uno de los tipos de datos que no aparezcan en estas notas.*

### Datos cualitativos

Las etiquetas o datos cualitativos son datos que se necesitan contar para tener información medible. 
Por lo que, para analizar este tipo de datos, primero aprenderemos a contar. 

Consideremos la siguiente base de datos de refrescos de preferencia.

```{r}
refrescos = c("Coke_Classic", "Pepsi", "Sprite", "Dr.Pepper")
set.seed(1548)
datos = sample(refrescos, 30, replace = T)
```

Algunas preguntas que nos pueden hacer sobre esta base de datos son

*¿Cuál es el refresco que más consumen?*

*¿Cuál es el refresco que menos consumen?*

*¿Podemos calcular una gráfica que resuma la información?*

Las primeras dos respuestas salen con el código

```{r}
resumen = table(datos)
resumen
```

En el ejemplo anterior, vemos que Pepsi es el refresco que más se consume con 10 repeticiones.
El refresco que menos se consume es Dr. Pepper con 5 repeticiones.

Para la tercera pregunta, si guardamos la tabla resumen (table()) en un objeto llamado resumen y 
a este nuevo objeto le aplicamos 

```{r}
barplot(resumen)
```

obtenemos una gráfica de barras con la correspondiente
información.

![Gráfico de barras](imagenes/barplot-refrescos.png)

Para más detalles de este ejemplo, consulta el código completo:

[Base de datos de refrescos](scripts/01_refrescos.R)

**NOTA:** Los siguientes ejemplos que mostramos dependerán del código anterior.
Por lo que es importante que corran los scripts en el orden cada vez que inicien sesión
y darle continuidad a estas notas.

Continuando con las mediciones, estas dependerán de las repeticiones que ya realizamos con el código 
**table()**. Formalmente, a estas repeticiones se les conoce como **frecuencias** y el nombre de los refrescos son 
llamadas **Clases**.

Otra medicion que realizaremos es la **frecuencia relativa**, la cual se calcula como

$$
\text{FR} = \frac{\text{frecuencia}}{n},
$$

donde $n$ sigue representando nuestro tamaño de muestra. En R, calculamos esto con el código

```{r}
n = length(datos)
```

Por lo que las frecuencias relativas se calculan en el siguiente script:

[Frecuencia relativa asociada](scripts/02_frecuencia-relativa.R)

Para que la información se guarde en un mismo objeto, convertiremos nuestra tabla en un **data.frame()**

[Tabla creada con un **data.drame()**](scripts/03_data-frame.R)

El resultado se ve de la siguiente forma:

![Resultados de las frecuencias y frecuencias relativa](imagenes/data-frame1.png)

Una característica importante de la frecuencia relativa es que la suma total es 1.

Otra medición que podemos realizar es la frecuencia porcentual, la cual se calcula como

$$
FP = 100*FR,
$$

en otras palabras, la frecuencia relativa representa una probabilidad. Para convertirla en porcentaje basta con
multiplicarla por 100.

El gráfico relacionado con este estadístico es la **gráfica circular** o de **pastel**. 

Retomando la base de datos original y la primera tabla, obtenemos el siguiente resultado:

![Gráfica de pastel](imagenes/pie1.png)

Estéticamente, podemos agregar los respectivos porcentajes, redondeando a dos decimales. Por lo que el resultado queda como sigue:

[Script para la frecuencua porcentual y gráfica de pastel](scripts/fporcentual_´pie.R)

![Gráfica de pastel con etiquetas más elaboradas](imagenes/pie2.png)

Una característica importante de la frecuencia porcentual es que la suma total es 100.



## Distribuciones de probabilidad

## Funciones de Momentos y Verosimilitud

## Estimación por intervalos

## Pruebas de hipótesis