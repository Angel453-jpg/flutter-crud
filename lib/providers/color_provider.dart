import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider extends ChangeNotifier {
  static const _colorKey = 'selectedColor';
  int _selectedColorIndex = 1; // Azul por defecto

  int get selectedColor => _selectedColorIndex;

  ColorProvider() {
    _loadSelectedColor();
  }

  Future<void> _loadSelectedColor() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedColorIndex = prefs.getInt(_colorKey) ?? 1;
    notifyListeners();
  }

  Future<void> setColor(int index) async {
    _selectedColorIndex = index;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, index);
  }
}
