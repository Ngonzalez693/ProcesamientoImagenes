# 🌦️ Interfaz Gráfica de Procesamiento de Imágenes y Visualización Climática

Este proyecto en MATLAB ofrece una interfaz gráfica interactiva para **cargar imágenes**, **procesarlas** mediante diferentes operadores, y **mostrar datos meteorológicos en tiempo real** sobre las imágenes, usando una API pública de estaciones meteorológicas en el nodo de la Universidad de San Buenaventura de Cali, Colombia.

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

---

## 🖥️ ¿Cómo usarlo?

1. Abre MATLAB y ejecuta el archivo `Proyecto.m`.
2. Se abrirá una ventana con la interfaz gráfica.
3. Usa los botones y sliders para:
   - Cargar una imagen.
   - Aplicar operadores.
   - Leer datos meteorológicos.
   - Personalizar visualización del texto climático.
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