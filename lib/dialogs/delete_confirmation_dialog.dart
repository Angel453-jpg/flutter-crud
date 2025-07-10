import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('¿Eliminar celular?'),
      content: const Text('Esta acción no se puede deshacer.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.delete),
          label: const Text('Eliminar'),
        ),
      ],
    ),
  );
}
