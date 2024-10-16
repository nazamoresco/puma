enum Season {
  winter,
  summer,
  fall,
  spring;

  String get imagePath {
    switch (this) {
      case Season.winter:
        return "estaciones_INVIERNO.webp";
      case Season.summer:
        return "estaciones_VERANO.webp";
      case Season.fall:
        return "estaciones_OTONIO.webp";
      case Season.spring:
        return "estaciones_PRIMAVERA.webp";
    }
  }
}
