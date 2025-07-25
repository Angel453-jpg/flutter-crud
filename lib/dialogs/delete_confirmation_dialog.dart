import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  final colorScheme = Theme.of(context).colorScheme;

  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Eliminar celular',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent, 
          child: AlertDialog(

            title: Text(
              '¿Eliminar celular?',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700, 
                fontSize: 22,
                color: colorScheme.onSurface, 
              ),
              textAlign: TextAlign.center, 
            ),
            content: Text(
              'Esta acción no se puede deshacer.',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant, 
              ),
              textAlign: TextAlign.center, 
            ),
            actionsAlignment: MainAxisAlignment.center, 
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 
                ),
                child: Text(
                  'Cancelar',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant, 
                  ),
                ),
              ),
              const SizedBox(width: 8), 
              ElevatedButton.icon(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete_rounded), 
                label: Text(
                  'Eliminar',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.error, 
                  foregroundColor: colorScheme.onError, 
                  elevation: 6, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), 
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack), 
        child: FadeTransition(
          opacity: animation, 
          child: child,
        ),
      );
    },
  );
}