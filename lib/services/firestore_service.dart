import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  //Obtiene el ID del usuario autenticado
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  //Referencia a la colección de celulares del usuario actual
  CollectionReference get userCellphones {
    final uid = currentUserId;
    if (uid == null) {
      throw Exception('Usuario no autenticado');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cellphones');
  }

  //Stream de los celulares del usuario actual, ordenados por marca
  Stream<QuerySnapshot> getCellphonesStream() {
    try {
      return userCellphones.orderBy('Marca').snapshots();
    } catch (_) {
      return const Stream.empty();
    }
  }

  //Agrega un nuevo celular a la colección del usuario
  Future<void> addCellphone(
    String brand,
    String model,
    String storage,
    double price,
  ) {
    return userCellphones.add({
      'Marca': brand,
      'Modelo': model,
      'Almacenamiento': storage,
      'Precio': price,
    });
  }

  //Actualiza un celular existente en la colección del usuario
  Future<void> updateCellphone(
    String docId,
    String brand,
    String model,
    String storage,
    double price,
  ) {
    return userCellphones.doc(docId).update({
      'Marca': brand,
      'Modelo': model,
      'Almacenamiento': storage,
      'Precio': price,
    });
  }

  //Elimina un celular de la colección del usuario
  Future<void> deleteCellphone(String docId) {
    return userCellphones.doc(docId).delete();
  }
}
