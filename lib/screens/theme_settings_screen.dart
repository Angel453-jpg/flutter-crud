import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/theme_provider.dart';
import 'package:flutter_crud/widgets/side_menu_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  ThemeMode? _selectedTheme;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      setState(() {
        _selectedTheme = themeProvider.themeMode;
      });
    });
  }

  void _onThemeChanged(ThemeMode? mode) {
    if (mode == null) return;
    setState(() {
      _selectedTheme = mode;
    });
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.setThemeMode(mode);
  }

  Widget _buildThemeOption(
    BuildContext context,
    IconData icon,
    Color color, 
    String label,
    ThemeMode value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _selectedTheme == value;

    return GestureDetector( 
      onTap: () => _onThemeChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), 
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
        padding: const EdgeInsets.all(16), 
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : colorScheme.background, 
          borderRadius: BorderRadius.circular(20), 
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withOpacity(0.3) 
                  : Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.withOpacity(0.1) 
                      : Colors.black.withOpacity(0.2), 
              blurRadius: isSelected ? 20 : 10, 
              offset: isSelected ? const Offset(0, 8) : const Offset(0, 4), 
            ),
          ],
          border: isSelected
              ? Border.all(color: color, width: 2) 
              : null, 
        ),
        child: Row( 
          children: [
           
            Icon(
              icon,
              color: isSelected ? color : colorScheme.onSurfaceVariant, 
              size: 32,
            ),
            const SizedBox(width: 16),

           
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.montserrat( 
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, 
                  fontSize: 18,
                  color: isSelected
                      ? color 
                      : colorScheme.onSurface, 
                ),
              ),
            ),

            Radio<ThemeMode>(
              activeColor: colorScheme.primary, 
              value: value,
              groupValue: _selectedTheme,
              onChanged: _onThemeChanged,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        title: Text(
          'Configuración', 
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: colorScheme.onBackground,
          ),
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onBackground, 
        ),
      ),
      drawer: const SideMenuDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selecciona el tema que más te guste',
                    style: GoogleFonts.montserrat( 
                      fontSize: 12, 
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 8), 

                  
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), 

            _buildThemeOption(context, Icons.light_mode_rounded, colorScheme.primary, 'Modo Claro', ThemeMode.light),
            _buildThemeOption(context, Icons.dark_mode_rounded, colorScheme.primary, 'Modo Oscuro', ThemeMode.dark),
            _buildThemeOption(context, Icons.settings_suggest_rounded, Colors.grey, 'Sistema', ThemeMode.system),
          ],
        ),
      ),
    );
  }
}