import 'package:flutter/material.dart';
import 'package:flutter_crud/controllers/cellphone_dialog_controller.dart';
import 'package:flutter_crud/dialogs/show_cellphone_dialog.dart';
import 'package:flutter_crud/services/firestore_service.dart';
import 'package:flutter_crud/widgets/cellphone_list.dart';
import 'package:flutter_crud/widgets/side_menu_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirestoreService dbService = FirestoreService();
  final controller = CellphoneDialogController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void openDialog({String? docId, Map<String, dynamic>? cellphone}) {
    controller.setValues(
      brand: cellphone?['Marca'],
      model: cellphone?['Modelo'],
      storage: cellphone?['Almacenamiento'],
      price: cellphone?['Precio']?.toString(),
    );

    showCellphoneDialog(
      context: context,
      docId: docId,
      controller: controller,
      dbService: dbService,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      drawer: const SideMenuDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(),
        child: const Icon(Icons.add),
      ),
      body: CellphoneList(
        onEdit: (cellphone, docId) {
          openDialog(docId: docId, cellphone: cellphone);
        },
      ),
    );
  }
}
