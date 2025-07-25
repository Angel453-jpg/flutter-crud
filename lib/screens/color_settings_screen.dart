import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/color_provider.dart';
import 'package:flutter_crud/theme/app_color.dart';
import 'package:flutter_crud/widgets/side_menu_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ColorSettingsScreen extends StatefulWidget {
  const ColorSettingsScreen({super.key});

  @override
  State<ColorSettingsScreen> createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  late int currentColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final colorProvider = Provider.of<ColorProvider>(context, listen: false);
      setState(() {
        currentColor = colorProvider.selectedColor;
      });
    });
  }

  void _selectColor(int index) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    colorProvider.setColor(index);
    setState(() {
      currentColor = index;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🎨 Color "${appColorsNames[index]}" seleccionado',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _resetColor() {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    colorProvider.setColor(0);
    setState(() {
      currentColor = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🎨 Color reseteado al predeterminado',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
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
          'Seleccionar Color',
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _resetColor,
        icon: Icon(Icons.refresh_rounded, color: colorScheme.onPrimary),
        label: Text(
          'Resetear color',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
        backgroundColor: colorScheme.primary,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
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
                    'Elige tu color principal',
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                itemCount: appColorsThemes.length,
                itemBuilder: (context, index) {
                  final color = appColorsThemes[index];
                  final isSelected = currentColor == index;

                  return GestureDetector(
                    onTap: () => _selectColor(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 8),
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
                          CircleAvatar(
                            backgroundColor: color,
                            radius: 24,
                            child: isSelected
                                ? Icon(Icons.check_rounded, color: colorScheme.onPrimary, size: 20)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              appColorsNames[index],
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? color : colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}