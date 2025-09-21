import 'package:flutter/material.dart';

class AppResponsive {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  AppResponsive(this.context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }

  ///  Obtenir une largeur relative (ex: 0.5 = 50% de l’écran)
  double wp(double percent) => screenWidth * percent;

  ///  Obtenir une hauteur relative (ex: 0.3 = 30% de l’écran)
  double hp(double percent) => screenHeight * percent;

  ///  Taille de police responsive
  double sp(double size) => (screenWidth / 375.0) * size;
}
