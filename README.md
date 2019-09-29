# Computacion Visual 2019 - 2S 
## Taller de análisis de imágenes por software

### Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

### Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

### Integrantes

Completar la tabla:

|          Integrante         |  github nick  |
|-----------------------------|---------------|
|  Edgar David Garay Forero   |   Edgarayf    |
| Antonio Jose Suarez Fortich |   Ajsuarezf   |


## Discusión

* Se crea el canvas con el tamaño para 4 imagenes la imgen 1 es la imgen original y de la 2 a la 4 muestran los resultados obtenidos 
* Se implementa la conversion a la escala de grises usando threshold, promedio rgb y por medio del brillo de los pixeles y se modifican las imgenes 1 2 3 para mostrar los resultados
* Se realizan las mascaras de convolucion haciendo uso de los kernel de identidad, sharpen y edge detection  

