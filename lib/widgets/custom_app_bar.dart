import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.settings),
          onSelected: (value) {
            final themeProvider = Provider.of<ThemeProvider>(
              context,
              listen: false,
            );
            String mensaje = '';

            if (value == 'light') {
              themeProvider.setThemeMode(ThemeMode.light);
              mensaje = '🌞 Modo claro activado';
            } else if (value == 'dark') {
              themeProvider.setThemeMode(ThemeMode.dark);
              mensaje = '🌙 Modo oscuro activado';
            } else if (value == 'system') {
              themeProvider.setThemeMode(ThemeMode.system);
              mensaje = '🖥️ Modo predeterminado por el sistema activado';
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(mensaje),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'light',
              child: ListTile(
                leading: Icon(Icons.light_mode),
                title: Text("Modo Claro"),
              ),
            ),
            const PopupMenuItem(
              value: 'dark',
              child: ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text("Modo Oscuro"),
              ),
            ),
            const PopupMenuItem(
              value: 'system',
              child: ListTile(
                leading: Icon(Icons.settings_suggest_outlined),
                title: Text("Predeterminado por el sistema"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
