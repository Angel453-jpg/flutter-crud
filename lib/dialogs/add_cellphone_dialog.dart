import 'package:flutter/material.dart';

class AddCellphoneDialog extends StatelessWidget {
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController storageController;
  final TextEditingController priceController;
  final VoidCallback onConfirm;

  const AddCellphoneDialog({
    super.key,
    required this.brandController,
    required this.modelController,
    required this.storageController,
    required this.priceController,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Celular'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: brandController, decoration: const InputDecoration(labelText: 'Marca')),
          TextField(controller: modelController, decoration: const InputDecoration(labelText: 'Modelo')),
          TextField(controller: storageController, decoration: const InputDecoration(labelText: 'Almacenamiento')),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Precio'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: onConfirm,
          child: const Text("Agregar"),
        ),
      ],
    );
  }
}
