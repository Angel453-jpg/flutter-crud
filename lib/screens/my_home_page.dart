import 'package:flutter/material.dart';
import 'package:flutter_crud/dialogs/add_cellphone_dialog.dart';
import 'package:flutter_crud/services/firestore_service.dart';
import 'package:flutter_crud/widgets/cellphone_list.dart';
import 'package:flutter_crud/widgets/custom_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirestoreService dbService = FirestoreService();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController storageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void showCellphoneDialog({
    String? docId,
    String? brand,
    String? model,
    String? storage,
    String? price,
  }) {
    brandController.text = brand ?? '';
    modelController.text = model ?? '';
    storageController.text = storage ?? '';
    priceController.text = price ?? '';

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Agregar/Editar',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: AddCellphoneDialog(
              brandController: brandController,
              modelController: modelController,
              storageController: storageController,
              priceController: priceController,
              isEditing: docId != null,
              onConfirm: () {
                final double? parsedPrice = double.tryParse(
                  priceController.text,
                );
                if (parsedPrice != null) {
                  if (docId == null) {
                    dbService.addCellphone(
                      brandController.text,
                      modelController.text,
                      storageController.text,
                      parsedPrice,
                    );
                  } else {
                    dbService.updateCellphone(
                      docId,
                      brandController.text,
                      modelController.text,
                      storageController.text,
                      parsedPrice,
                    );
                  }
                  brandController.clear();
                  modelController.clear();
                  storageController.clear();
                  priceController.clear();
                  Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      floatingActionButton: FloatingActionButton(
        onPressed: showCellphoneDialog,
        child: const Icon(Icons.add),
      ),
      body: CellphoneList(
        onEdit: (cellphone, docId) {
          showCellphoneDialog(
            docId: docId,
            brand: cellphone['Marca'],
            model: cellphone['Modelo'],
            storage: cellphone['Almacenamiento'],
            price: cellphone['Precio']?.toString(),
          );
        },
      ),
    );
  }
}
