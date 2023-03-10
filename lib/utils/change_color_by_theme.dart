import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

void changeColorByTheme() {
  colorBox = isDarkMode ? Colors.black.withOpacity(0.4) : Colors.white;
  colorBoxShadow =
      !isDarkMode ? Colors.grey.withOpacity(0.5) : Colors.transparent;
  textColor = isDarkMode ? Colors.white : Colors.black;
  bottomNavColor = isDarkMode ? Colors.black : colorApp;
  textNav = !isDarkMode
      ? Colors.grey.withOpacity(0.5)
      : Colors.white.withOpacity(0.5);
  white = isDarkMode ? Colors.black : Colors.white;
  black = !isDarkMode ? Colors.black : Colors.white;
}
