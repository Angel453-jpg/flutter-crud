import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/color_settings_screen.dart';
import 'package:flutter_crud/screens/theme_settings_screen.dart';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Configuraciones',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Tema'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => ThemeSettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Color personalizado'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ColorSettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
