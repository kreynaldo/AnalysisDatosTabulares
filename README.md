# Curso Práctico de Análisis de Datos Tabulares

---

## **INFORMACIÓN GENERAL DEL CURSO**

### **Público Objetivo**
- Estudiantes sin conocimientos previos de programación o análisis de datos
- Profesionales que desean incorporar análisis de datos en su trabajo
- Personas interesadas en ciencia de datos desde los fundamentos

### **Objetivos Generales**
1. Dominar las herramientas fundamentales para análisis de datos tabulares
2. Desarrollar competencias en Python, R y SQL para manipulación de datos
3. Comprender y aplicar conceptos estadísticos básicos
4. Crear y evaluar modelos predictivos

---

## **MÓDULO 1: INTRODUCCIÓN AL CURSO**

### **1.1 Fundamentos Conceptuales**

#### **¿Qué entendemos por datos tabulares?**
- Filas, columnas, celdas
- Tipos de datos: numéricos, categóricos, fechas, texto
- **Ejercicio**: Identificar tipos de datos en datasets reales

#### **El proceso de análisis de datos**
- Recolección → Limpieza → Exploración → Modelado → Comunicación
- Herramientas para cada etapa
- **Ejercicio**: Mapear herramientas a etapas del proceso

### **1.2 Primeros Pasos**

#### **Sesión 1.2.1: R Básico**
- Vectores y data.frames
- Funciones básicas
- Instalación y carga de paquetes
- **Ejercicios**: Ejemplos didácticos

#### **Sesión 1.2.1: Python Básico**
- Variables y tipos de datos
- Listas, diccionarios
- Funciones básicas
- Importación de librerías
- **Ejercicios**: Ejemplos didácticos

---

## **MÓDULO 2: ANÁLISIS EXPLORATORIO DE DATOS**

### **2.1 Carga y Exploración Inicial de Datos**

#### **Sesión 2.1.1: Pandas Básico**
- Series y DataFrames desde cero
- Lectura de archivos CSV, Excel, JSON
- Primeras exploraciones: `.info()`, `.describe()`, `.head()`
- **Dataset**: Ventas de una tienda online (1000-5000 registros)
- **Ejercicios**: 
  - Cargar datos
  - Explorar estructura
  - Identificar problemas

#### **Sesión 2.1.2: dplyr y tidyr en R**
- Filosofía tidy data
- Funciones básicas: `select()`, `filter()`, `mutate()`, `summarise()`
- Mismo dataset que en Python
- **Ejercicios graduales**: Mismas tareas que con pandas

### **2.2 Limpieza y Transformación de Datos**

#### **Sesión 2.2.1: Identificación de Problemas en Datos**
- Datos faltantes: tipos y patrones
- Duplicados: identificación y manejo
- Outliers: detección visual y estadística
- Inconsistencias: formatos, codificación
- **Dataset "sucio"**: Datos reales con múltiples problemas
- **Ejercicio**: Crear reporte de calidad de datos

#### **Sesión 2.2.2: Técnicas de Limpieza en Python**
- Manejo de valores faltantes con pandas
- Detección y remoción de duplicados
- Transformación de tipos de datos
- Normalización de texto
- **Ejercicios progresivos**: Limpiar el dataset "sucio"

#### **Sesión 2.2.3: Técnicas de Limpieza en R**
- Funciones de tidyverse para limpieza
- Manejo de NA values
- Funciones de stringr para texto
- **Ejercicios progresivos**: Mismo dataset, técnicas de R

### **2.3 Estadística Descriptiva Básica**

#### **Sesión 2.3.1: Conceptos Estadísticos Fundamentales**
- Medidas de tendencia central: media, mediana, moda
- Medidas de dispersión: varianza, desviación estándar, rango
- Distribuciones básicas
- Correlación vs. causalidad
- **Ejercicios**: Calcular estadísticas manualmente y con código

#### **Sesión 2.3.2: Estadística Descriptiva en Python**
- Métodos de pandas para estadística
- scipy.stats básico
- **Ejercicio**: Análisis estadístico de dataset de ventas

#### **Sesión 2.3.3: Estadística Descriptiva en R**
- Funciones base de R
- Paquetes summary y psych
- **Ejercicio**: Mismo análisis estadístico en R

---

## **MÓDULO 3: BASES DE DATOS RELACIONALES**

### **3.1 Fundamentos de Bases de Datos Relacionales**

#### **Sesión 3.1.1: Conceptos de Bases de Datos Relacionales**
- ¿Por qué bases de datos vs. archivos?
- Modelo relacional: tablas, filas, columnas
- Claves primarias y foráneas
- **Ejercicio**: Diseñar esquema para tienda online

#### **Sesión 3.1.2: Introducción a SQL**
- SELECT básico: proyección y filtrado
- WHERE, ORDER BY, LIMIT
- **Dataset**: Base de datos de empleados (pequeña)
- **Ejercicios progresivos**: Queries cada vez más complejas

### **3.2 SQL Intermedio**

#### **Sesión 3.2.1: Agregaciones y Agrupaciones**
- GROUP BY y HAVING
- Funciones de agregación: COUNT, SUM, AVG, MAX, MIN
- **Ejercicios**: Análisis de ventas por región, tiempo, producto

#### **Sesión 3.2.2: JOINs**
- INNER, LEFT, RIGHT, FULL OUTER JOINs
- Cuándo usar cada tipo
- **Dataset**: Sistema multi-tabla (usuarios, pedidos, productos)
- **Ejercicios progresivos**: Queries con múltiples tablas

#### **Sesión 3.2.3: Subconsultas y CTEs**
- Subconsultas en WHERE y SELECT
- Common Table Expressions (WITH)
- **Ejercicios**: Análisis complejos multi-nivel

---

## **MÓDULO 4: ENTRENAMIENTO Y EVALUACIÓN DE MODELOS**

### **4.1 Fundamentos de Machine Learning**

#### **Sesión 4.1.1: Conceptos de Machine Learning**
- Supervisado vs. no supervisado
- Regresión vs. clasificación
- Overfitting y underfitting
- Train/validation/test splits
- **Ejercicio conceptual**: Identificar tipos de problemas

#### **Sesión 4.1.2: Preparación de Datos para ML**
- Feature engineering básico
- Encoding de variables categóricas
- Normalización y estandarización
- **Dataset**: Predicción de precios de casas
- **Ejercicio**: Preparar datos para modelos

#### **Sesión 4.1.3: Estadística Inferencial Básica**
- Intervalos de confianza
- Pruebas de hipótesis básicas
- p-values y significancia
- **Ejercicio**: Análisis A/B simple

### **4.2 Modelos de Regresión**

#### **Sesión 4.2.1: Regresión Lineal en Python**
- scikit-learn básico
- LinearRegression, métricas
- Interpretación de coeficientes
- **Ejercicio**: Predecir precios usando características numéricas

#### **Sesión 4.2.2: Regresión Lineal en R**
- lm() function
- summary() y diagnostic plots
- **Ejercicio**: Mismo problema en R

#### **Sesión 4.2.3: Evaluación de Modelos**
- MSE, RMSE, MAE, R²
- Validación cruzada
- **Ejercicio**: Comparar modelos Python vs R

### **4.3 Modelos de Clasificación**

#### **Sesión 4.3.1: Clasificación en Python**
- LogisticRegression, DecisionTreeClassifier
- Métricas: accuracy, precision, recall, F1
- Matriz de confusión
- **Dataset**: Clasificación de clientes (churn prediction)
- **Ejercicio**: Modelo completo de clasificación

#### **Sesión 4.3.2: Clasificación en R**
- glm() para regresión logística
- Paquetes caret y randomForest
- **Ejercicio**: Mismo problema de clasificación

#### **Sesión 4.3.3: Interpretación de Modelos**
- Feature importance
- Interpretación de coeficientes
- **Ejercicio**: Explicar modelo a stakeholder no técnico

---

## **MÓDULO 5: DISEÑO DE CUADROS DE MANDO**

### **5.1 Fundamentos de Business Intelligence**

#### **Sesión 5.1.1: Conceptos de BI y KPIs**
- ¿Qué es un dashboard efectivo?
- KPIs vs. métricas
- Audiencia y objetivos
- **Ejercicio**: Definir KPIs para diferentes roles

#### **Sesión 5.1.2: Diseño Visual y UX**
- Principios de diseño para dashboards
- Jerarquía visual
- Colores y tipografía
- Heramientas de visualización: Looker
- **Ejercicio**: Rediseñar dashboard existente

### **5.2 Programación de Dashboards**

#### **Sesión 5.2.1: Dashboards con Streamlit**
- Streamlit básico
- Widgets y interactividad
- Deployment básico
- **Ejercicio**: Dashboard interactivo para ventas

#### **Sesión 5.2.2: Dashboards con Shiny**
- Shiny básico en R
- UI y server logic
- **Ejercicio**: Convertir dashboard de Streamlit a Shiny

---

## **MÓDULO 6: PROYECTO FINAL**

### **6.1 Definición y Planificación del Proyecto**
- Selección de dataset y problemática
- Definición de objetivos y métricas de éxito
- Planificación de timeline
- **Entregable**: Propuesta de proyecto

### **6.2 Desarrollo del Proyecto**
- Implementación siguiendo metodología aprendida
- Uso de herramientas múltiples (Python, R, SQL)
- Documentación en notebooks
- **Entregable**: Notebooks documentados y código

### **6.3 Presentación y Comunicación**
- Preparación de presentación ejecutiva
- Dashboard final
- Documentación técnica
- **Entregable**: Presentación + dashboard + documentación
