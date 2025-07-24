import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/color_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/theme/app_color.dart';
import 'package:provider/provider.dart';

class ColorSettingsScreen extends StatefulWidget {
  const ColorSettingsScreen({super.key});

  @override
  State<ColorSettingsScreen> createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final currentColor = colorProvider.selectedColor;

    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Color')),
      body: ListView.builder(
        itemCount: appColorThemes.length,
        itemBuilder: (context, index) {
          final color = appColorThemes[index];
          return ListTile(
            leading: CircleAvatar(backgroundColor: color),
            title: Text(appColorNames[index]),
            trailing: currentColor == index ? const Icon(Icons.check) : null,
            onTap: () {
              colorProvider.setColor(index);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            },
          );
        },
      ),
    );
  }
}
