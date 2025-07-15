import 'package:flutter/material.dart';

class CellphoneDialogController {
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final storageController = TextEditingController();
  final priceController = TextEditingController();

  void setValues({
    String? brand,
    String? model,
    String? storage,
    String? price,
  }) {
    brandController.text = brand ?? '';
    modelController.text = model ?? '';
    storageController.text = storage ?? '';
    priceController.text = price ?? '';
  }

  void clear() {
    brandController.clear();
    modelController.clear();
    storageController.clear();
    priceController.clear();
  }

  void dispose() {
    brandController.dispose();
    modelController.dispose();
    storageController.dispose();
    priceController.dispose();
  }
}
