# MÓDULO 3: R y RStudio

## 🎯 Objetivo general:

Mostrar qué es R, qué hace RStudio, y ver un ejemplo real de análisis de datos **reproducible** en R.

## 1️⃣ Introducción

* Objetivo: contextualizar R en el ecosistema de análisis de datos.

Temas clave:

* ¿Qué es R?
    * Lenguaje estadístico y de análisis de datos.
    * Open source, extensible con miles de paquetes.

* ¿Qué es RStudio?
    * Entorno de desarrollo (IDE) para R.
    * Organización del flujo de trabajo: scripts, consola, entorno, visualizaciones, proyectos.

* Comparación breve con otros lenguajes: Excel, SQL, Python (sin entrar en polémicas)

* Breve mención del ecosistema tidyverse como "forma moderna" de trabajar con datos.

Tip: mostrar rápidamente la interfaz de RStudio (los 4 paneles) y decir qué hace cada uno.

## 2️⃣ Primeros pasos prácticos

**Objetivo**: demostrar que R es accesible.

Temas y demo sugeridos:
* Crear un script nuevo.
* Operaciones básicas (asignaciones, funciones simples).
* Crear un data frame sencillo o usar mtcars.
* Mostrar cómo explorar datos:
```r
head(mtcars)
summary(mtcars)
str(mtcars)
```
* Explicar brevemente cómo instalar y cargar paquetes
```r
install.packages("tidyverse")
library(tidyverse)
```

## 3️⃣ Ejemplo práctico: análisis con tidyverse

**Objetivo**: mostrar el poder de R para análisis reales.

**Sugerencia**: usar un dataset conocido (gapminder, penguins, o mpg de ggplot2).

**Pasos**:

1. Leer datos (read_csv() o usar un dataset integrado).

2. Explorar con glimpse(), summary().

3. Manipular con dplyr:

```r
library(dplyr)
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(promedio_vida = mean(lifeExp))
```

4. Visualizar con ggplot2:
```r
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()
```

5. Mostrar cómo guardar una gráfica o exportar datos.

💡Tip: no entrar en sintaxis avanzada, enfocar en mostrar que todo fluye con lógica y es legible.

## 4️⃣ Reproducibilidad y buenas prácticas

**Objetivo**: destacar por qué R es poderoso en entornos de análisis.

* R como herramienta para **análisis reproducibles**.
* Uso de proyectos en RStudio.
* Scripts y notebooks (R Markdown, Quarto).
* Mención rápida de la integración con Git/GitHub y Copilot.

💡Tip: muestra un R Markdown renderizado a HTML o PDF con código y resultados integrados.

## 5️⃣ Cierre y recursos

**Objetivo**: dejar a los asistentes con vías para seguir aprendiendo.

* Recursos recomendados:
    * https://r4ds.hadley.nz/
    * https://posit.co/learn
    * https://rstudio.cloud
* Comunidades: R-Ladies, RStudio Community, Stack Overflow.
* Mostrar cómo abrir la ayuda (?mean, help(package = "dplyr")).
