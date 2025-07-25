import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

class CellphoneTitle extends StatelessWidget {
  final Map<String, dynamic> cellphone;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CellphoneTitle({
    super.key,
    required this.cellphone,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12, 
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            
            Icon(
              Icons.phone_android_rounded, 
              size: 40, 
              color: colorScheme.primary, 
            ),
            const SizedBox(width: 16), 

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cellphone['Marca'] ?? 'N/A', 
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700, 
                      fontSize: 18, 
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4), 

                  Text(
                    cellphone['Modelo'] ?? 'N/A',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500, 
                      fontSize: 16,
                      color: colorScheme.onSurface, 
                    ),
                  ),
                  const SizedBox(height: 8), 

                  Row(
                    children: [
                      Icon(Icons.sd_storage_rounded, size: 18, color: colorScheme.onSurfaceVariant), 
                      const SizedBox(width: 4),
                      Text(
                        cellphone['Almacenamiento'] ?? 'N/A',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant, 
                        ),
                      ),
                      const SizedBox(width: 16), 
                      Icon(Icons.attach_money_rounded, size: 18, color: colorScheme.primary), 
                      const SizedBox(width: 4),
                      Text(
                        '${cellphone['Precio']?.toStringAsFixed(2) ?? '0.00'}', 
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600, 
                          fontSize: 16,
                          color: colorScheme.primary, 
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column( 
              mainAxisSize: MainAxisSize.min, 
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.edit_rounded, 
                  color: colorScheme.secondary, 
                  onTap: onEdit,
                  tooltip: 'Editar',
                ),
                const SizedBox(height: 8), 
                _buildActionButton(
                  context,
                  icon: Icons.delete_rounded, 
                  color: colorScheme.error, 
                  onTap: onDelete,
                  tooltip: 'Eliminar',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    String? tooltip,
  }) {
    return InkWell( 
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), 
      child: Container(
        padding: const EdgeInsets.all(8.0), 
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), 
          borderRadius: BorderRadius.circular(12), 
        ),
        child: Icon(
          icon,
          size: 24, 
          color: color, 
        ),
      ),
    );
  }
}