# Tecnico

Este documento tiene como objetivo detallar y justificar las decisiones técnicas adoptadas durante el desarrollo del proyecto.

### Audio
* Elección de librería: Durante las primeras fases, me encontré con problemas de latencia en el audio usando la librería `audioplayers`. Para solucionar este problema, decidí cambiar a `flame_audio`.
  *  Es importante destacar que, aunque `flame_audio` utiliza `audioplayers` como base, está especialmente optimizado para videojuegos, lo que explica la notable mejora en la latencia.

### Provider
* En aras de mejorar el rendimiento, realicé una reubicación y especialización de los listeners.
  * Al comienzo, los listeners configurados con `provider` eran demasiado generales, lo que causaba una serie de recalculaciones innecesarias. Solucioné este inconveniente siendo más específico y asignando los listeners exactamente donde eran necesarios, localizando su alcance.

### IsometricGridLayoutDelegate

* La utilizacion de `IsometricGridLayoutDelegate` que extiende `MultiChildLayoutDelegate` resulto en una mejora de performance respecto a `IsometricGrid` que funcionaba con varias `List.generate` funciones y `Stack`.

### Precarga de images

Los cultivos desaparecian entre las etapas de crecimiento, esto se debia a que se tenia que carga la imagen correspondiente a la nueva etapa, y eso tomaba tiempo. Para solucionar este problema se creo una pagina de carga donde se descargan las imagenes necesarias para el nivel de antemano, eliminando estas latencias.