import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/auth_provider.dart';
import 'package:flutter_crud/screens/login/login_screen.dart';
import 'package:flutter_crud/screens/theme/theme_settings_screen.dart';
import 'package:provider/provider.dart';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: FutureBuilder<String?>(
              future: Provider.of<AuthProvider>(
                context,
                listen: false,
              ).getUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Text(
                    'Bienvenido',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
                }

                final firstName = snapshot.data!.split(' ').first;

                return Text(
                  'Hola $firstName 👋',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Temas'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => ThemeSettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () async {
              Navigator.of(context).pop();
              await Provider.of<AuthProvider>(context, listen: false).logout();

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
