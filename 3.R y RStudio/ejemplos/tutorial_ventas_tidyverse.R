# ============================================================================
# TUTORIAL COMPLETO DE TIDYVERSE EN R - DESDE CERO
# ============================================================================

# 1. INSTALACIÓN Y CARGA DE PAQUETES
# ============================================================================

# Instalar tidyverse (solo necesario la primera vez)
# install.packages("tidyverse")

# Cargar el paquete
library(tidyverse)

# tidyverse incluye estos paquetes principales:
# - dplyr: manipulación de datos
# - ggplot2: visualización
# - readr: lectura de datos
# - tidyr: reorganización de datos
# - stringr: manipulación de strings
# - forcats: trabajo con factores

# 2. CREACIÓN DE DATOS DE EJEMPLO
# ============================================================================

# Vamos a crear un dataset de ejemplo sobre ventas de una tienda

set.seed(123)  # Para que los resultados sean reproducibles

productos = c("Laptop", "Mouse", "Teclado", "Monitor", "Auriculares")
vendedores = c("Ana", "Carlos", "María", "Pedro", "Laura")

ventas <- tibble(
  fecha = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day"),
  producto = sample(productos, 365, replace = TRUE),
  vendedor = sample(vendedores, 365, replace = TRUE),
  cantidad = sample(1:10, 365, replace = TRUE),
  precio_unitario = case_when(
    producto == "Laptop" ~ runif(365, 800, 1200),
    producto == "Monitor" ~ runif(365, 200, 400),
    producto == "Teclado" ~ runif(365, 30, 80),
    producto == "Mouse" ~ runif(365, 15, 50),
    producto == "Auriculares" ~ runif(365, 25, 100)
  )
) %>%
  mutate(
    mes = month(fecha, label = TRUE),
    trimestre = quarter(fecha),
    venta_total = cantidad * precio_unitario
  )

# La expresión: valor %>% function(params)
# Es equivalente a: function(valor, params)
# Ejemplo:
ventas %>% head(5)
# Es igual a:
head(ventas, 5)

# El operador: %>% es idéntico al operador: |>
ventas |> head(5)

# El operador de asignación: <- se puede remplazar por el signo =
ejemplo = ventas |> head(5)

ejemplo

ejemplo = NA # anula un objeto

rm(ejemplo) # elimina fisicamente la variable del entorno


# Veamos nuestros datos
print("Primeras 10 filas de nuestro dataset:")
head(ventas, 10)

print("\nEstructura del dataset:")
glimpse(ventas)

# 3. FUNCIONES BÁSICAS DE DPLYR
# ============================================================================

print("\n=== FUNCIONES BÁSICAS DE DPLYR ===")

# 3.1 SELECT - Seleccionar columnas
print("\n3.1 SELECT - Seleccionar columnas específicas:")
ventas_basico = ventas |> select(fecha, producto, venta_total)
head(ventas_basico, 5)

# Seleccionar por rango de columnas
ventas_rango = ventas |> select(producto : precio_unitario)
head(ventas_rango, 3)

# 3.2 FILTER - Filtrar filas
print("\n3.2 FILTER - Filtrar filas según condiciones:")

# Filtrar ventas de laptops
laptops <- ventas %>%
  filter(producto == "Laptop")
print(paste("Ventas de laptops:", nrow(laptops)))

# Filtrar ventas mayores a $500
ventas_altas <- ventas %>%
  filter(venta_total > 500)
print(paste("Ventas mayores a $500:", nrow(ventas_altas)))

# Filtros múltiples
ventas_filtradas <- ventas %>%
  filter(producto %in% c("Laptop", "Monitor"), 
         mes %in% c("ene", "feb", "mar"))
print(paste("Ventas de Laptop/Monitor en Q1:", nrow(ventas_filtradas)))

# 3.3 MUTATE - Crear nuevas columnas
print("\n3.3 MUTATE - Crear nuevas variables:")

ventas_extended <- ventas %>%
  mutate(
    precio_con_iva = precio_unitario * 1.21,
    categoria_venta = case_when(
      venta_total < 100 ~ "Baja",
      venta_total < 500 ~ "Media",
      TRUE ~ "Alta"
    ),
    dia_semana = wday(fecha, label = TRUE)
  )

# Mostrar las nuevas columnas
ventas_extended %>%
  select(producto, venta_total, categoria_venta, dia_semana) %>%
  head(8)

# 3.4 ARRANGE - Ordenar datos
print("\n3.4 ARRANGE - Ordenar datos:")

# Ordenar por venta total (descendente)
top_ventas <- ventas %>%
  arrange(desc(venta_total)) %>%
  head(5)

print("Top 5 ventas más altas:")
top_ventas %>%
  select(fecha, producto, vendedor, venta_total)

# 3.5 GROUP_BY y SUMMARISE - Resúmenes agrupados
print("\n3.5 GROUP_BY y SUMMARISE - Análisis agrupado:")

# Resumen por producto
resumen_producto <- ventas %>%
  group_by(producto) %>%
  summarise(
    total_ventas = sum(venta_total),
    promedio_venta = mean(venta_total),
    cantidad_transacciones = n(),
    precio_min = min(precio_unitario),
    precio_max = max(precio_unitario),
    .groups = 'drop'
  ) %>%
  arrange(desc(total_ventas))

print("Resumen por producto:")
print(resumen_producto)

# Resumen por vendedor y mes
resumen_vendedor_mes <- ventas %>%
  group_by(vendedor, mes) %>%
  summarise(
    ventas_mes = sum(venta_total),
    transacciones = n(),
    .groups = 'drop'
  ) %>%
  arrange(vendedor, desc(ventas_mes))

print("\nTop 3 meses para cada vendedor:")
top_vendedores <- resumen_vendedor_mes %>%
  group_by(vendedor) %>%
  slice_max(ventas_mes, n = 3) %>%
  ungroup()

print(top_vendedores)

# 4. ANÁLISIS AVANZADO CON PIPES (%>%)
# ============================================================================

print("\n=== ANÁLISIS AVANZADO CON PIPES ===")

# 4.1 Análisis de tendencias mensuales
tendencia_mensual <- ventas %>%
  group_by(mes, producto) %>%
  summarise(
    venta_promedio = mean(venta_total),
    total_mes = sum(venta_total),
    .groups = 'drop'
  ) %>%
  group_by(mes) %>%
  mutate(
    participacion = total_mes / sum(total_mes) * 100
  ) %>%
  arrange(mes, desc(participacion))

print("\n4.1 Participación por producto cada mes (top 2):")
tendencia_mensual %>%
  group_by(mes) %>%
  slice_max(participacion, n = 2) %>%
  select(mes, producto, participacion) %>%
  print()

# 4.2 Análisis de performance de vendedores
performance_vendedores <- ventas %>%
  group_by(vendedor) %>%
  summarise(
    total_vendido = sum(venta_total),
    promedio_por_venta = mean(venta_total),
    total_transacciones = n(),
    productos_únicos = n_distinct(producto),
    mejor_producto = producto[which.max(venta_total)],
    mejor_venta = max(venta_total),
    .groups = 'drop'
  ) %>%
  mutate(
    ranking = dense_rank(desc(total_vendido)),
    efectividad = total_vendido / total_transacciones
  ) %>%
  arrange(ranking)

print("\n4.2 Performance de vendedores:")
print(performance_vendedores)

# 5. TIDYR - REORGANIZACIÓN DE DATOS
# ============================================================================

print("\n=== TIDYR - REORGANIZACIÓN DE DATOS ===")

# 5.1 PIVOT_WIDER - De formato largo a ancho
ventas_wide <- ventas %>%
  group_by(mes, producto) %>%
  summarise(total = sum(venta_total), .groups = 'drop') %>%
  pivot_wider(names_from = producto, values_from = total, values_fill = 0)

print("\n5.1 Tabla pivoteada (meses vs productos):")
print(ventas_wide[1:6, 1:4])  # Primeras 6 filas y 4 columnas

# 5.2 PIVOT_LONGER - De formato ancho a largo
ventas_long <- ventas_wide %>%
  pivot_longer(cols = -mes, names_to = "producto", values_to = "venta_total") %>%
  filter(venta_total > 0)

print("\n5.2 Datos en formato largo (muestra):")
print(head(ventas_long, 8))

# 6. STRINGR - MANIPULACIÓN DE STRINGS
# ============================================================================

print("\n=== STRINGR - MANIPULACIÓN DE STRINGS ===")

# Crear datos con strings para manipular
ventas_strings <- ventas %>%
  mutate(
    descripcion = paste(cantidad, "x", producto, "vendido por", vendedor),
    producto_upper = str_to_upper(producto),
    vendedor_inicial = str_sub(vendedor, 1, 1),
    es_laptop = str_detect(producto, "Laptop"),
    producto_limpio = str_replace_all(producto, " ", "_")
  )

print("\n6. Ejemplos de manipulación de strings:")
ventas_strings %>%
  select(descripcion, producto_upper, vendedor_inicial, es_laptop) %>%
  head(5) %>%
  print()

# 7. ANÁLISIS FINAL COMBINANDO TODAS LAS HERRAMIENTAS
# ============================================================================

print("\n=== ANÁLISIS FINAL INTEGRAL ===")

analisis_final <- ventas %>%
  # Agregar información temporal
  mutate(
    estacion = case_when(
      mes %in% c("dic", "ene", "feb") ~ "Verano",
      mes %in% c("mar", "abr", "may") ~ "Otoño", 
      mes %in% c("jun", "jul", "ago") ~ "Invierno",
      TRUE ~ "Primavera"
    ),
    dia_semana = wday(fecha, label = TRUE),
    es_fin_semana = dia_semana %in% c("sáb", "dom")
  ) %>%
  # Agrupar y resumir
  group_by(estacion, vendedor, producto) %>%
  summarise(
    ventas_totales = sum(venta_total),
    cantidad_vendida = sum(cantidad),
    precio_promedio = mean(precio_unitario),
    transacciones = n(),
    .groups = 'drop'
  ) %>%
  # Calcular métricas adicionales
  group_by(estacion) %>%
  mutate(
    participacion_estacion = ventas_totales / sum(ventas_totales) * 100,
    ranking_en_estacion = dense_rank(desc(ventas_totales))
  ) %>%
  ungroup() %>%
  # Filtrar top performers
  filter(ranking_en_estacion <= 3) %>%
  arrange(estacion, ranking_en_estacion)

print("\nTop 3 combinaciones vendedor-producto por estación:")
print(analisis_final %>% 
        select(estacion, vendedor, producto, ventas_totales, participacion_estacion))

# 8. RESUMEN DE INSIGHTS
# ============================================================================

print("\n=== RESUMEN DE INSIGHTS PRINCIPALES ===")

# Producto más vendido
producto_top <- ventas %>%
  group_by(producto) %>%
  summarise(total = sum(venta_total)) %>%
  slice_max(total, n = 1)

print(paste("Producto más vendido:", producto_top$producto, 
            "con $", round(producto_top$total, 2)))

# Vendedor más efectivo
vendedor_top <- performance_vendedores %>%
  slice_max(efectividad, n = 1)

print(paste("Vendedor más efectivo:", vendedor_top$vendedor,
            "con $", round(vendedor_top$efectividad, 2), "por transacción"))

# Mes con más ventas
mes_top <- ventas %>%
  group_by(mes) %>%
  summarise(total = sum(venta_total)) %>%
  slice_max(total, n = 1)

print(paste("Mejor mes:", mes_top$mes, "con $", round(mes_top$total, 2)))

print("\n¡Tutorial de tidyverse completado!")
print("Has aprendido las funciones principales: select, filter, mutate, arrange,")
print("group_by, summarise, pivot_wider/longer, y manipulación de strings.")