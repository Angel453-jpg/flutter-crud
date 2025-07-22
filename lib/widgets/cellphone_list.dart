import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/dialogs/delete_confirmation_dialog.dart';
import 'package:flutter_crud/widgets/cellphone_title.dart';

import '../services/firestore_service.dart';

class CellphoneList extends StatelessWidget {
  final Function(Map<String, dynamic> cellphone, String docId) onEdit;

  const CellphoneList({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final dbService = FirestoreService();

    return StreamBuilder<QuerySnapshot>(
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
            final doc = docs[index];
            final cellphone = doc.data() as Map<String, dynamic>;

            return CellphoneTitle(
              cellphone: cellphone,
              onEdit: () => onEdit(cellphone, doc.id),
              onDelete: () => showDeleteConfirmationDialog(
                context: context,
                onConfirm: () {
                  dbService.deleteCellphone(doc.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Celular eliminado correctamente'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.fixed,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
