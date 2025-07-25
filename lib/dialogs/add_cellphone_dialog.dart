import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        isEditing ? 'Editar Celular' : 'Agregar Celular',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
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
                  decoration: InputDecoration(
                    labelText: 'Marca',
                    prefixIcon: Icon(Icons.business_rounded),
                  ),
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
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: modelController,
                  decoration: InputDecoration(
                    labelText: 'Modelo',
                    prefixIcon: Icon(Icons.phone_android_rounded),
                  ),
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
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: storageController,
                  decoration: InputDecoration(
                    labelText: 'Almacenamiento',
                    hintText: 'Ej. 128GB, 1TB',
                    prefixIcon: Icon(Icons.sd_storage_rounded),
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
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                    hintText: 'Ej. 599.99',
                    prefixIcon: Icon(Icons.attach_money_rounded),
                  ),
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
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.onSurfaceVariant,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
          child: const Text("Cancelar"),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              onConfirm();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
          child: Text(isEditing ? 'Actualizar' : 'Guardar'),
        ),
      ],
    );
  }
}