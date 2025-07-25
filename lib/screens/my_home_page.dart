import 'package:flutter/material.dart';
import 'package:flutter_crud/dialogs/add_cellphone_dialog.dart';
import 'package:flutter_crud/services/firestore_service.dart';
import 'package:flutter_crud/widgets/cellphone_list.dart';
import 'package:flutter_crud/widgets/side_menu_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io'; // Para el exit(0) en el Drawer, aunque no se usa en este archivo

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

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    storageController.dispose();
    priceController.dispose();
    super.dispose();
  }

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
      transitionDuration: const Duration(milliseconds: 400),
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
                final double? parsedPrice = double.tryParse(priceController.text);
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

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        docId == null
                            ? '📱 Celular registrado exitosamente'
                            : '✏️ Celular actualizado exitosamente',
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: colorScheme.onBackground,
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: colorScheme.onBackground,
          ),
        ),
      ),
      drawer: const SideMenuDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showCellphoneDialog,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        icon: Icon(Icons.add_rounded, color: colorScheme.onPrimary),
        label: Text(
          "Agregar",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: colorScheme.onPrimary,
          ),
        ),
        elevation: 8,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Bienvenido a BlueCell!',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Gestiona tus celulares de forma eficiente.',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
           
            Card(
              margin: const EdgeInsets.only(bottom: 20.0),
              color: colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.info_rounded, size: 36, color: colorScheme.onPrimaryContainer),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Consejo del día:',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            'Mantén tus registros actualizados para una mejor gestión.',
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Tus dispositivos registrados:',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ),
              ),
            ),
            Expanded(
              child: CellphoneList(
                onEdit: (cellphone, docId) {
                  showCellphoneDialog(
                    docId: docId,
                    brand: cellphone['Marca'],
                    model: cellphone['Modelo'],
                    storage: cellphone['Almacenamiento'],
                    price: cellphone['Precio']?.toString(),
                  );
                },
                onDelete: (docId) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        '¿Eliminar celular?',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                      ),
                      content: Text(
                        'Esta acción no se puede deshacer.',
                        style: GoogleFonts.montserrat(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancelar',
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            dbService.deleteCellphone(docId);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '🗑️ Celular eliminado exitosamente',
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context).colorScheme.onError),
                                ),
                                backgroundColor: Colors.red[700],
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.all(16),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: colorScheme.onError,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            elevation: 4,
                          ),
                          child: Text(
                            'Eliminar',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}