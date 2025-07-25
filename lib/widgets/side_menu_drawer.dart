import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/color_settings_screen.dart';
import 'package:flutter_crud/screens/theme_settings_screen.dart';
import 'dart:io';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: Container(
        color: colorScheme.surface,  
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary, 
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/icons/blue_cell_logo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            
            ListTile(
              leading: Icon(Icons.phone_android, color: colorScheme.secondary),
              title: Text('Lista de celulares'),
              onTap: () {
                Navigator.of(context).pop();  
                Navigator.pushNamed(context, '/lista-celulares');
              },
            ),

            ListTile(
              leading: Icon(Icons.brightness_6, color: colorScheme.primary),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ThemeSettingsScreen()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.palette, color: colorScheme.secondary),
              title: const Text('Color personalizado'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ColorSettingsScreen()),
                );
              },
            ),

            Divider(thickness: 1, height: 32, color: colorScheme.onSurface.withOpacity(0.3)),

            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: const Text('Salir de la app'),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
