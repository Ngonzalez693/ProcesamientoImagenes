# Interfaz de Procesamiento de Imágenes y Detección de Objetos en MATLAB

Este proyecto es una interfaz gráfica desarrollada en MATLAB para el procesamiento y análisis de imágenes, con integración de datos meteorológicos y herramientas avanzadas de segmentación y visualización. 
🌦️ La interfaz gráfica interactiva permite **cargar imágenes**, **procesarlas** mediante diferentes operadores, y **mostrar datos meteorológicos en tiempo real** sobre las imágenes, usando una API pública de estaciones meteorológicas en el nodo de la Universidad de San Buenaventura de Cali, Colombia.
La interfaz también permite hacer una **detección de objetos** y eliminarlos, mostrando la detección mediante diferentes formas.

---

## 🚀 Funcionalidades Principales

### 📷 Carga y visualización de imagen
- Carga imágenes en formato `.jpg`, `.png`, o `.bmp`.
- Muestra la imagen original junto con:
  - Versión en escala de grises.
  - Canales rojo, verde y azul.
  - Histogramas para cada canal.

### 🎛️ Procesamiento de imagen
- Aplica diferentes operadores de procesamiento:
  - **Operador Umbral**: Binarización simple según umbral 1.
  - **Operador Intervalo de Umbral**: Segmentación entre dos umbrales.
  - **Operador Gris con Intervalo**: Eliminación de valores fuera del intervalo manteniendo niveles de gris.
  - **Operador de Extensión**: Realza el contraste mediante expansión de intensidades.

### 📡 Integración con API Climática
- Consulta datos reales desde la API de la estación `0703060003` (Cali).
- Muestra en la interfaz valores como:
  - Ruido ambiental
  - Radiación solar
  - Índice UV
  - Temperatura
  - Velocidad y dirección del viento

### 🎨 Personalización del Texto Climático
- Personaliza el texto superpuesto sobre la imagen:
  - Tamaño de fuente
  - Colores RGB (Rojo, Verde, Azul)

### 🧠 Modo Inteligente vs Manual
- **Modo automático**: El sistema ajusta colores y operadores automáticamente con base en la temperatura.
- **Modo manual**: Permite control total sobre los valores de color y procesamiento.

## Detección de Objetos y Visualización de Contornos

- La interfaz permite detectar y visualizar objetos en la imagen procesada, con varias opciones de visualización para los contornos:
  - **Detección de objetos** con selección de área mínima.
  - **Visualización de contornos**: contorno, rectángulo, círculo o todos combinados.

### Parámetros de Detección

- **Área mínima (slider):** Filtra objetos pequeños, ajustando el valor mínimo de área para considerar un objeto válido.
- **Operación morfológica:** Mejora la segmentación usando operaciones como cierre para eliminar ruido y rellenar huecos.
- **Forma de visualización:** Selecciona cómo quieres ver los objetos detectados:
  - **Contorno:** Dibuja el borde de cada objeto.
  - **Rectángulo:** Dibuja el rectángulo delimitador de cada objeto.
  - **Círculo:** Dibuja un círculo equivalente al área de cada objeto.
  - **Todos:** Muestra simultáneamente el contorno, el rectángulo y el círculo de cada objeto.
  
---

## 🖥️ ¿Cómo usarlo?

1. Abre MATLAB y ejecuta el archivo `Proyecto.m`.
2. Se abrirá una ventana con la interfaz gráfica.
3. Usa los botones y sliders para:
   - Cargar una imagen.
   - Aplicar operadores.
   - Leer datos meteorológicos.
   - Personalizar visualización del texto climático.
   - Realizar detección de objetos y eliminarlos.
4. Activa o desactiva el **Modo Manual** para alternar entre ajustes automáticos y personalizados.

---

## ⚙️ Requisitos

- MATLAB (recomendado R2019b o superior)
- Conexión a Internet (para lectura de la API)
- Toolboxes requeridos:
  - Image Processing Toolbox
  - Web Access habilitado

---

## 👨‍💻 Autores

Proyecto desarrollado por un estudiante de **Ingeniería Multimedia**:

- Nicolás González.
- Juliana Mejía.
- Camilo González.
- Valentina Betancourt.