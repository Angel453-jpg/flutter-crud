import 'package:flutter/material.dart';

class AddCellphoneDialog extends StatelessWidget {
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController storageController;
  final TextEditingController priceController;
  final VoidCallback onConfirm;
  final bool isEditing;

  AddCellphoneDialog({
    super.key,
    required this.brandController,
    required this.modelController,
    required this.storageController,
    required this.priceController,
    required this.onConfirm,
    this.isEditing = false,
  });

  final _formKey = GlobalKey<FormState>();
  final RegExp _textRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
  final RegExp _storageRegex = RegExp(r'^\d+(GB|gb|TB|tb)$');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Editar Celular' : 'Agregar Celular'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: brandController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    if (!_textRegex.hasMatch(value)) {
                      return 'Solo letras, números y espacios';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: modelController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    if (!_textRegex.hasMatch(value)) {
                      return 'Solo letras, números y espacios';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: storageController,
                  decoration: const InputDecoration(
                    labelText: 'Almacenamiento',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    if (!_storageRegex.hasMatch(value)) {
                      return 'Debe terminar en GB o TB (ej. 128GB, 1TB)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    final price = double.tryParse(value);
                    if (price == null || price < 0) {
                      return 'Precio inválido';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              onConfirm();
            }
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}
