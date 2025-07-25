import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 


const List<Color> appColorsThemes = [
  
  Color(0xFFEF5350), 
  Color.fromARGB(255, 125, 177, 255), 
  Color(0xFF4DB6AC), 
  Color(0xFF81C784), 
  Color(0xFFFFEE58), 
  Color(0xFFFFB74D), 
  Color(0xFFF06292), 
];

const List<String> appColorsNames = [
  'Rojo',
  'Azul',
  'Verde Azulado',
  'Verde',
  'Amarillo',
  'Naranja',
  'Rosa',
];

class AppColor {
  final int selectedColor;

  AppColor({this.selectedColor = 0})
      : assert(
          selectedColor >= 0 && selectedColor < appColorsThemes.length,
          'Colors must be between 0 and ${appColorsThemes.length - 1}',
        );

  ThemeData theme(Brightness brightness) {
    
    final Color effectivePrimaryColor = appColorsThemes[selectedColor];

    final Color lightSurface = const Color(0xFFF7F9FC); 
    final Color lightBackground = const Color(0xFFFFFFFF); 
    final Color lightOnBackground = const Color(0xFF212121);
    final Color lightOnSurfaceVariant = const Color(0xFF757575); 

    
    final Color darkSurface = const Color(0xFF1E1E1E); 
    final Color darkBackground = const Color(0xFF282828); 
    final Color darkOnBackground = const Color(0xFFE0E0E0); 
    final Color darkOnSurfaceVariant = const Color(0xFFA0A0A0); 

   
    final Color errorColor = const Color(0xFFE53935); 
    final Color onErrorColor = Colors.white;

    
  
    final Color onPrimaryColor = Colors.white; 

    return ThemeData(
      brightness: brightness,
      
      useMaterial3: true,

     
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: effectivePrimaryColor, 
        onPrimary: onPrimaryColor,
        secondary: effectivePrimaryColor.withOpacity(0.8), 
        onSecondary: onPrimaryColor,
        error: errorColor,
        onError: onErrorColor,
        background: brightness == Brightness.light ? lightBackground : darkBackground,
        onBackground: brightness == Brightness.light ? lightOnBackground : darkOnBackground,
        surface: brightness == Brightness.light ? lightSurface : darkSurface,
        onSurface: brightness == Brightness.light ? lightOnBackground : darkOnBackground,
        surfaceVariant: brightness == Brightness.light ? lightBackground : darkBackground, 
        onSurfaceVariant: brightness == Brightness.light ? lightOnSurfaceVariant : darkOnSurfaceVariant,
      ),

     
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent, 
        foregroundColor: brightness == Brightness.light ? lightOnBackground : darkOnBackground,
        titleTextStyle: GoogleFonts.montserrat( 
          fontWeight: FontWeight.w700,
          fontSize: 26,
          color: brightness == Brightness.light ? lightOnBackground : darkOnBackground,
        ),
        iconTheme: IconThemeData(
          color: brightness == Brightness.light ? lightOnBackground : darkOnBackground, 
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 6, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), 
        ),
        color: brightness == Brightness.light ? lightBackground : darkBackground, 
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0), 
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: brightness == Brightness.light ? lightBackground : darkBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0), 
        ),
        elevation: 10, 
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: effectivePrimaryColor, 
        contentTextStyle: GoogleFonts.montserrat(color: onPrimaryColor), 
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: effectivePrimaryColor, 
        foregroundColor: onPrimaryColor, 
        elevation: 8, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), 
        ),
      ),

     
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.light
            ? lightSurface 
            : darkBackground.withOpacity(0.4), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0), 
          borderSide: BorderSide.none, 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none, 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: effectivePrimaryColor, width: 2.0),
        ),
        labelStyle: GoogleFonts.montserrat(
          color: brightness == Brightness.light ? lightOnSurfaceVariant : darkOnSurfaceVariant, 
        ),
        prefixIconColor: brightness == Brightness.light ? lightOnSurfaceVariant : darkOnSurfaceVariant, 
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), 
      ),

      textTheme: TextTheme(
       
        titleLarge: GoogleFonts.montserrat(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: brightness == Brightness.light ? lightOnBackground : darkOnBackground,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: brightness == Brightness.light ? lightOnBackground : darkOnBackground,
        ),
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 16,
          color: brightness == Brightness.light ? lightOnBackground : darkOnBackground,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 14,
          color: brightness == Brightness.light ? lightOnSurfaceVariant : darkOnSurfaceVariant,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: onPrimaryColor,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: brightness == Brightness.light ? lightOnSurfaceVariant : darkOnSurfaceVariant,
        ),
      ),
    );
  }
}