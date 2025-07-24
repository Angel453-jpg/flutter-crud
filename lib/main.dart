import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/config/firebase_options.dart';
import 'package:flutter_crud/providers/auth_provider.dart';
import 'package:flutter_crud/providers/color_provider.dart';
import 'package:flutter_crud/providers/theme_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/theme/app_color.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
      title: "BluCell",
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: AppColor(
        selectedColor: colorProvider.selectedColor,
      ).theme(Brightness.light),
      darkTheme: AppColor(
        selectedColor: colorProvider.selectedColor,
      ).theme(Brightness.dark),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
