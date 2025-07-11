import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentTheme = themeProvider.themeMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Temas')),
      body: ListView(
        children: [
          RadioListTile<ThemeMode>(
            title: Row(
              children: const [
                Icon(Icons.light_mode, color: Colors.orange),
                SizedBox(width: 12),
                Text('Modo Claro'),
              ],
            ),
            value: ThemeMode.light,
            groupValue: currentTheme,
            onChanged: (value) => themeProvider.setThemeMode(value!),
          ),
          RadioListTile<ThemeMode>(
            title: Row(
              children: const [
                Icon(Icons.dark_mode, color: Colors.indigo),
                SizedBox(width: 12),
                Text('Modo Oscuro'),
              ],
            ),
            value: ThemeMode.dark,
            groupValue: currentTheme,
            onChanged: (value) => themeProvider.setThemeMode(value!),
          ),
          RadioListTile<ThemeMode>(
            title: Row(
              children: const [
                Icon(Icons.settings_suggest_outlined, color: Colors.grey),
                SizedBox(width: 12),
                Text('Por Defecto del sistema'),
              ],
            ),
            value: ThemeMode.system,
            groupValue: currentTheme,
            onChanged: (value) => themeProvider.setThemeMode(value!),
          ),
        ],
      ),
    );
  }
}
