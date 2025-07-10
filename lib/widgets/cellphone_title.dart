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
    return ListTile(
      leading: const Icon(Icons.phone_android),
      title: Text(cellphone['Marca'] ?? ''),
      subtitle: Text(
        "${cellphone['Modelo'] ?? ''} - ${cellphone['Almacenamiento'] ?? ''} - \$${cellphone['Precio']?.toStringAsFixed(2) ?? '0.00'}",
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit),
            color: Colors.orange,
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
