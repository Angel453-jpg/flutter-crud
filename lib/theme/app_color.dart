import 'package:flutter/material.dart';

const Color _customColor = Color(0xFFEE0030);

const List<Color> appColorsThemes = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

const List<String> appColorsNames = [
  'Rojo',
  'Azul',
  'Verde Azulado',
  'Verde',
  'Amarillo',
  'Naranja',
  'Rosa',
];

class AppColor {
  final int selectedColor;

  AppColor({this.selectedColor = 0})
    : assert(
        selectedColor >= 0 && selectedColor < appColorsThemes.length,
        'Colors must be between 0 and ${appColorsThemes.length - 1}',
      );

  ThemeData theme(Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      colorSchemeSeed: appColorsThemes[selectedColor],
      useMaterial3: true,
    );
  }
}
