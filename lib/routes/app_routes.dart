import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/screens/my_home_page.dart';
import 'package:flutter_crud/screens/register/register_screen.dart';
import 'package:flutter_crud/screens/theme/theme_settings_screen.dart';

import '../screens/login/login_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const themeSettings = '/theme-settings';

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    home: (_) => const MyHomePage(title: 'Gestión de Celulares'),
    themeSettings: (_) => const ThemeSettingsScreen(),
  };
}
