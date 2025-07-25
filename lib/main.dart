import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/firebase_options.dart';
import 'package:flutter_crud/providers/color_provider.dart';
import 'package:flutter_crud/providers/theme_provider.dart';
import 'package:flutter_crud/screens/splash_screen.dart';
import 'package:flutter_crud/screens/my_home_page.dart'; 
import 'package:flutter_crud/theme/app_color.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);

    return MaterialApp(
      title: "BlueCell",
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: AppColor(
        selectedColor: colorProvider.selectedColor,
      ).theme(Brightness.light),
      darkTheme: AppColor(
        selectedColor: colorProvider.selectedColor,
      ).theme(Brightness.dark),

      routes: {
        '/lista-celulares': (context) => const MyHomePage(title: 'Lista de celulares'),
      },

      home: const SplashScreen(),
    );
  }
}
