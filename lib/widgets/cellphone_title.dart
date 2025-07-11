import 'package:flutter/material.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: const Icon(Icons.phone_android, size: 32),
        title: Text(
          cellphone['Marca'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "${cellphone['Modelo'] ?? ''} - ${cellphone['Almacenamiento'] ?? ''} - \$${cellphone['Precio']?.toStringAsFixed(2) ?? '0.00'}",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withAlpha(178),
          ),
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: Colors.orange),
              tooltip: 'Editar',
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Eliminar',
            ),
          ],
        ),
      ),
    );
  }
}
