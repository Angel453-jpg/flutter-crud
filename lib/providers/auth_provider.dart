import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? user;

  bool get isLoggedIn => user != null;

  bool _shouldShowLogoutMessage = false;

  bool get shouldShowLogoutMessage => _shouldShowLogoutMessage;

  AuthProvider() {
    _authService.userChanges.listen((u) {
      user = u;
      notifyListeners();
    });
  }

  Future<bool> login(String email, String password) async {
    try {
      await _authService.login(email, password);
      return true;
    } catch (e) {
      debugPrint('Error al iniciar sesión: $e');
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
  }) async {
    try {
      await _authService.register(
        email: email,
        password: password,
        nombre: nombre,
        apellido: apellido,
      );
      return true;
    } catch (e) {
      debugPrint('Error al registrarse: $e');
      return false;
    }
  }

  Future<String?> getUserName() async {
    final uid = user?.uid;
    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    final data = doc.data();
    if (data == null) return null;

    final nombre = data['nombre'] ?? '';
    final apellido = data['apellido'] ?? '';
    return '$nombre $apellido';
  }

  void markLogoutMessageAsShown() {
    _shouldShowLogoutMessage = false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _shouldShowLogoutMessage = true;
  }
}
