import 'package:flutter/material.dart';
import 'package:flutter_crud/dialogs/add_cellphone_dialog.dart';

import '../controllers/cellphone_dialog_controller.dart';
import '../services/firestore_service.dart';

Future<void> showCellphoneDialog({
  required BuildContext context,
  String? docId,
  required CellphoneDialogController controller,
  required FirestoreService dbService,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Agregar/editar',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: AddCellphoneDialog(
            brandController: controller.brandController,
            modelController: controller.modelController,
            storageController: controller.storageController,
            priceController: controller.priceController,
            isEditing: docId != null,
            onConfirm: () {
              final parsedPrice = double.tryParse(
                controller.priceController.text,
              );
              if (parsedPrice == null) return;

              if (docId == null) {
                dbService.addCellphone(
                  controller.brandController.text,
                  controller.modelController.text,
                  controller.storageController.text,
                  parsedPrice,
                );
              } else {
                dbService.updateCellphone(
                  docId,
                  controller.brandController.text,
                  controller.modelController.text,
                  controller.storageController.text,
                  parsedPrice,
                );
              }

              controller.clear();
              Navigator.of(context).pop();

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      docId == null
                          ? '📱 Celular registrado exitosamente'
                          : '✏️ Celular actualizado exitosamente',
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
