import 'package:flutter/material.dart';
import 'package:flutter_crud/theme/app_color.dart';
import 'package:provider/provider.dart';

import '../providers/color_provider.dart';

class ColorSettingsScreen extends StatelessWidget {
  const ColorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final currentColor = colorProvider.selectedColor;

    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Color')),
      body: ListView.builder(
        itemCount: appColorsThemes.length,
        itemBuilder: (context, index) {
          final color = appColorsThemes[index];

          return ListTile(
            leading: CircleAvatar(backgroundColor: color),
            title: Text(appColorsNames[index]),
            trailing: currentColor == index ? const Icon(Icons.check) : null,
            onTap: () {
              colorProvider.setColor(index);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
