import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference cellphones = FirebaseFirestore.instance.collection(
    'cellphones',
  );

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

  Stream<QuerySnapshot> getCellphonesStream(){
    return cellphones.orderBy('Marca').snapshots();
  }
}
