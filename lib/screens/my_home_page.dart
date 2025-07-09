import 'package:flutter/material.dart';
import 'package:flutter_crud/dialogs/add_cellphone_dialog.dart';
import 'package:flutter_crud/services/firestore_service.dart';
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

  void showCellphoneDialog() {
    showDialog(
      context: context,
      builder: (context) => AddCellphoneDialog(
        brandController: brandController,
        modelController: modelController,
        storageController: storageController,
        priceController: priceController,
        onConfirm: () {
          final double? price = double.tryParse(priceController.text);
          if (price != null) {
            dbService.addCellphone(
              brandController.text,
              modelController.text,
              storageController.text,
              price,
            );
            brandController.clear();
            modelController.clear();
            storageController.clear();
            priceController.clear();
            Navigator.of(context).pop();
          }
        },
      ),
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
      body: StreamBuilder(
        stream: dbService.getCellphonesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("❌ Error al cargar los datos"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("📱 No hay celulares registrados"));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final cellphone = docs[index];
              return ListTile(
                leading: const Icon(Icons.phone_android),
                title: Text(cellphone['Marca'] ?? ''),
                subtitle: Text(
                  "${cellphone['Modelo'] ?? ''} - ${cellphone['Almacenamiento'] ?? ''}",
                ),
                trailing: Text("\$${cellphone['Precio'].toString()}"),
              );
            },
          );
        },
      ),
    );
  }
}
