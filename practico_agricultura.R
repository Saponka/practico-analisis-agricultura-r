# ============================================
# PRÁCTICO R - DATOS AGRICULTURA
# ============================================

# 1 - Crear variable datos para cargar el archivo csv
datos <- read.csv("datos_agricultura.csv")

# 2 - Mostrar los primeros 6 registros
#head() para mostrar por defecto los primeros 6 archivos
head(datos)
#head(datos, 6)mostrar archivos que se le indica en el segundo parametro
head(datos, 6)

# 3 - ¿Cuántos lotes contiene la base?
#cada fila representa un lote
nrow(datos)
#Pero si un mismo lote aparece varias veces
length(unique(datos$lote))

# 4-¿Qué variables contiene?
#names(datos) muestra los nombres de las variables.
names(datos)

# 5 - Variables categóricas y numéricas
#str(datos) muestra:nombre de la variable,tipo de variable,algunos valores
# categoricas: chr numericas: int, num
str(datos)
#identificar las variables.
sapply(datos, class)

# 6 - Resumen estadístico
# summary mostrara: Min., 1st Qu., Median, Mean, 3rd Qu., Max.
summary(datos)

# ============================================
# PARTE 2   Medidas de tendencia central
# ============================================
#Utilizando la variable rendimiento_t_ha:

# 7 - Calcular la media

#mean()  calcula la media
#datos$rendimiento_t_ha → selecciona la variable
#na.rm = TRUE ignora valores faltantes

mean(datos$rendimiento_t_ha)
#resultado: 4.736667

# agregamos como parametrp, na.rm = TRUE si hubiera valores faltantes (NA) :
mean(datos$rendimiento_t_ha, na.rm = TRUE)
#guardar media en variable
media <- mean(datos$rendimiento_t_ha, na.rm = TRUE)

# 8 - Calcular la mediana
mediana <- median(datos$rendimiento_t_ha, na.rm = TRUE)
#resultado:  3.95

# 9 - Determinar la moda (valor que aparece con mayor frecuencia)

#table() muestra cuántas veces aparece cada rendimiento
tabla <- table(datos$rendimiento_t_ha)

#tabla[which.max(tabla)] indica cuál es la frecuencia máxima
tabla[which.max(tabla)]

#obtener el valor que corresponde a esa frecuencia
as.numeric(names(tabla)[which.max(tabla)])

#moda
moda <- as.numeric(names(tabla)[which.max(tabla)])
#respuesta: 3

# 10 - Comparar media y mediana

#media : 4.736667
#mediana : 3.95

#¿Son similares?

#no son similares
# diferencia: 0.79 t/ha aproximadamente.

#¿Qué información aporta esta comparación?

#la media está por encima de la mediana.
#valores de rendimiento relativamente altos están elevando la media.

# ============================================
# PARTE 3  Medidas de dispersión y posición
# ============================================

# 11 - Mínimo y máximo
#min() obtener el minimo
#max() obtener el maximo
minimo <- min(datos$rendimiento_t_ha, na.rm = TRUE)
# respuesta: 2.6
maximo <- max(datos$rendimiento_t_ha, na.rm = TRUE)
#respuesta. 8.1

# 12. Calcular el rango (rango: Máximo − Mínimo)
#nos indica la amplitud total de los rendimientos observados
rango <- maximo - minimo
#respuesta: 5.5

# 13 - Obtener Q1, Q2 y Q3 (Primer cuartil,Segundo cuartil,Tercer cuartil)

#quantile() Por defecto divide los datos en cuatro partes
#cuartiles:0%,25%,50%,75%,100%)
quantile(datos$rendimiento_t_ha, na.rm = TRUE)

#Primer cuartil
quantile(datos$rendimiento_t_ha, 0.25, na.rm = TRUE)
#respuesta:   25%  - 3.125

#Segundo cuartil
quantile(datos$rendimiento_t_ha, 0.50, na.rm = TRUE)
#respuesta:  50%  - 3.95

#Tercer cuartil
quantile(datos$rendimiento_t_ha, 0.75, na.rm = TRUE)
#respuesta:  75% - 6.875

#los 3 cuartiles juntos
cuartiles <- quantile(
  datos$rendimiento_t_ha,
  probs = c(0.25, 0.50, 0.75),
  na.rm = TRUE
)
#repuesta:    cuartiles
#          25%   50%   75%
#         3.125 3.950 6.875


# 14 - Calcular el rango intercuartílico (IQR)
# mide la amplitud del 50 % central de los datos
# formula IQR = Q3 − Q1

#IQR() calcula el rango  intercuartílico de un conjunto de datos numéricos
IQR(datos$rendimiento_t_ha, na.rm = TRUE)
# respuesta: 3.75

# crear variable y almacenar el resultado de la resta
# de variables cuartiles[3] menos cuartiles[1]
iqr_manual <- cuartiles[3] - cuartiles[1]

# 15 - ¿Entre qué valores se encuentra el 50 % central?

q1 <- 2.80
q2 <- 3.95
q3 <- 5.20
# respuesta: El 50% se encuentra entre 2,80 t/ha y 5,20 t/ha.

# ============================================

# minimo: 2,6 t/ha
# maximo: 8,1 t/ha
# 11: 3,125 t/ha
# 12 (mediana): 3,950 t/ha
# 13: 6,875 t/ha
# IQR: 3,75 t/ha

# ============================================
# PARTE 4  GRAFICOS
# ============================================

# ============================================
#  Gráfico de barras
# muestrar la cantidad de lotes correspondientes a cada cultivo.
# ============================================
library(ggplot2)

ggplot(datos, aes(x = cultivo)) +
  geom_bar() +
  labs(
    title = "Cantidad de lotes por cultivo",
    x = "Cultivo",
    y = "Cantidad de lotes"
  )

# geom_bar() cuenta automáticamente cuántas observaciones
# existen para cada categoría de cultivo.

# revisamos los datos
table(datos$cultivo)

# ============================================
# Histograma (permite observar cómo se distribuyen los rendimientos)
# Construir un histograma de rendimiento_t_ha
# describir brevemente la distribución.
# ============================================

ggplot(datos, aes(x = rendimiento_t_ha)) +
  geom_histogram(bins = 8) +
  labs(
    title = "Distribución del rendimiento",
    x = "Rendimiento (t/ha)",
    y = "Cantidad de lotes"
  )

#¿Qué tenemos que observar?

# dónde se concentran los valores
# si la distribución es aproximadamente simétrica
# si existe asimetría
# si aparecen valores extremos
# si existen uno o varios grupos de valores

# media = 4,736667
# mediana = 3,95

# la media es bastante mayor que la mediana,
# debemos prestar atención a la presencia de valores altos
# que puedan estar desplazando la media.

# ============================================
# Boxplot
# rendimiento para cada cultivo
# Comparar las distribuciones
# ============================================

ggplot(datos, aes(x = cultivo, y = rendimiento_t_ha)) +
  geom_boxplot() +
  labs(
    title = "Distribución del rendimiento por cultivo",
    x = "Cultivo",
    y = "Rendimiento (t/ha)"
  )

#¿Qué tenemos que comparar?

# Para cada cultivo podemos observar:

# mediana → línea dentro de la caja
# Q1 y Q3 → límites de la caja
# dispersión → tamaño de la caja y los bigotes
# valores atípicos → puntos alejados
# diferencias entre cultivos

# si un cultivo tiene una caja mucho más grande que otro:
# Ese cultivo presenta mayor dispersión en sus rendimientos.

# Si las medianas están a diferentes alturas:
# Los valores centrales del rendimiento difieren entre cultivos.

# ============================================
# Gráfico de dispersión
# ============================================
# lluvia_mm en X
# rendimiento_t_ha en Y

ggplot(datos, aes(x = lluvia_mm, y = rendimiento_t_ha)) +
  geom_point() +
  labs(
    title = "Relación entre lluvia y rendimiento",
    x = "Lluvia (mm)",
    y = "Rendimiento (t/ha)"
  )

#¿Observa alguna relación?

# Si los puntos muestran una tendencia ascendente:
# podría existir una relación positiva
# a mayor lluvia, mayores rendimientos

# Si muestran una tendencia descendente:
# podría existir una relación negativa

# Si están completamente dispersos:
# no se observa una relación lineal clara.

# Se observa una tendencia desendente de lluvias

# ============================================
# Gráfico de torta
# representar la proporción de lotes según tipo_suelo
# ============================================

# Primero calculamos las cantidades:

# contamos los lotes por tipo de suelo
table(datos$tipo_suelo)
# Convertir esa tabla en un DataFrame
suelo <- as.data.frame(table(datos$tipo_suelo))

# Tenemos dos columnas:
# Var1 → tipo de suelo
# Freq → cantidad de lotes

# Cambiar los nombres de las columnas
# cambia: Var1 ,Freq a tipo_suelo, cantidad
names(suelo) <- c("tipo_suelo", "cantidad")

# Calculamos el porcentaje:

suelo$porcentaje <- suelo$cantidad / sum(suelo$cantidad) * 100

# suelo$cantidad = 8,7,15
# sum(suelo$cantidad) suma todas las cantidades : 8 + 7 + 15 = 30
# 8/30 *100 = 26.66 , 7/30 *100 = 23.33 , 15/30 *100 = 50
#  agrega en suelo esos resultados como una nueva columna: porcentaje

# geom_text() agrega texto al gráfico

# label = paste0(round(porcentaje, 1), "%"))
# porcentaje texto a mostrar
# round(porcentaje, 1) redondea a 1 decimal
# "%" , Agrega el símbolo %
# position_stack(vjust = 0.5) coloque el texto en el centro de cada porción

ggplot(suelo, aes(x = "", y = cantidad, fill = tipo_suelo)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  geom_text(
    aes(label = paste0(round(porcentaje, 1), "%")),
    position = position_stack(vjust = 0.5)
  ) +
  labs(
    title = "Proporción de lotes según tipo de suelo",
    fill = "Tipo de suelo"
  )

# tipo de suelo más frecuente: suelo Franco , representa el 50 % de los lotes
# los Arcillosos representan el 26,67 %
# los Arenosos representan el 23,33 %
# la mitad de los lotes corresponden a suelos de tipo Franco


# ============================================
# Parte 5 — Pregunta de negocio: efecto del riego
# ============================================

# 16 - Construir un boxplot de rendimiento_t_ha según riego

# Eje X : riego , Eje Y : rendimiento_t_ha

ggplot(datos, aes(x = riego, y = rendimiento_t_ha)) +
  geom_boxplot() +
  labs(
    title = "Rendimiento según disponibilidad de riego",
    x = "Riego",
    y = "Rendimiento (t/ha)"
  )

# boxplot nos permite comparar:
# mediana , dispersión valores mínimos y máximos , posibles valores atípicos.

# 17 - Calcular el rendimiento medio de los lotes con riego

table(datos$riego)
# mean() pero filtrando solamente los lotes que tienen riego

media_riego <- mean(
  datos$rendimiento_t_ha[datos$riego == "Si"],
  na.rm = TRUE
)

# respuesta:  5.66

# 18 - Calcular el rendimiento medio de los lotes sin riego

media_sin_riego <- mean(
  datos$rendimiento_t_ha[datos$riego == "No"],
  na.rm = TRUE
)
# respuesta: 3.813333

# 19 - ¿Cuál presenta mayor rendimiento promedio?

# Sin riego: 3.813333 t/ha
# Con riego: 5.66 t/ha
# diferencia : 5,66 − 3,813333 = 1,846667 t/ha

# Los lotes con riego presentan un rendimiento promedio aproximadamente de:
# 1,85 t/ha superior que los lotes sin riego.


# 20 - Escribir una breve interpretación de los resultados
# Recuerde que una diferencia descriptiva
# no demuestra por sí sola una relación causal.


# En la base analizada los lotes con riego presentan
# un rendimiento promedio de 5,66 t/ha, mientras que
#  los lotes sin riego presentan un rendimiento promedio de 3,81 t/ha.

# Por lo tanto, se observa una diferencia descriptiva
# de aproximadamente 1,85 t/ha a favor de los lotes con riego.

# Estos resultados sugieren una asociación entre la disponibilidad de riego
# y mayores niveles de rendimiento en los datos analizados.

# Sin embargo, esta diferencia descriptiva no permite afirmar que el riego
# sea por sí solo la causa del mayor rendimiento, ya que pueden intervenir
# otros factores, como el cultivo, el tipo de suelo, las precipitaciones,
# las condiciones climáticas y las prácticas de manejo.
