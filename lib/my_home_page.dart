import 'package:flutter/material.dart';
import 'package:flutter_crud/firestore_service.dart';

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
      builder: (context) => AlertDialog(
        title: const Text('Agregar Celular'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: brandController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              controller: modelController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: storageController,
              decoration: InputDecoration(labelText: 'Almacenamiento'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
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
                Navigator.of(context);
              }
            },
            child: const Text("Agregar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: showCellphoneDialog,
        child: const Icon(Icons.add),
      ),
      body: const Center(child: Text("Aquí ira la lista de celulares")),
    );
  }
}
