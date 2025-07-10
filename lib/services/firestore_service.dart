import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference cellphones = FirebaseFirestore.instance.collection(
    'cellphones',
  );

  Stream<QuerySnapshot> getCellphonesStream() {
    return cellphones.orderBy('Marca').snapshots();
  }

  Future<void> addCellphone(
    String brand,
    String model,
    String storage,
    double price,
  ) {
    return cellphones.add({
      'Marca': brand,
      'Modelo': model,
      'Almacenamiento': storage,
      'Precio': price,
    });
  }

  Future<void> updateCellphone(
    String docId,
    String brand,
    String model,
    String storage,
    double price,
  ) {
    return cellphones.doc(docId).update({
      'Marca': brand,
      'Modelo': model,
      'Almacenamiento': storage,
      'Precio': price,
    });
  }

  Future<void> deleteCellphone(String docId) {
    return cellphones.doc(docId).delete();
  }
}
