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

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  AuthProvider() {
    _authService.userChanges.listen((u) {
      user = u;
      _isInitialized = true;
      notifyListeners();
    });
  }

  Future<String?> login(String email, String password) async {
    try {
      await _authService.login(email, password);
      return null; //Éxito
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No existe una cuenta con ese correo.';
      } else if (e.code == 'wrong-password') {
        return 'La contraseña incorrecta.';
      } else if (e.code == 'invalid-email') {
        return 'Correo electrónico inválido.';
      } else if (e.code == 'user-disabled') {
        return 'La cuenta ha sido deshabilitada.';
      } else {
        return 'Credenciales inválidas. Intente nuevamente.';
      }
    } catch (e) {
      debugPrint('Error inesperado al iniciar sesión: $e');
      return 'Ocurrió un error inesperado. Intente nuevamente más tarde.';
    }
  }

  Future<String?> register({
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
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'El correo electrónico ya está en uso por otra cuenta.';
      } else if (e.code == 'invalid-email') {
        return 'Correo electrónico inválido.';
      } else if (e.code == 'weak-password') {
        return 'La contraseña es demasiado débil.';
      } else {
        return 'Error al registrar la cuenta. Intente nuevamente.';
      }
    } catch (e) {
      debugPrint('Error inesperado al registrarse: $e');
      return 'Ocurrió un error inesperado. Intente nuevamente más tarde.';
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

  Future<String?> resetPassword(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      return null;
    } on FirebaseAuthException {
      return 'Si el correo está registrado, recibirás instrucciones para restablecer tu contraseña.';
    } catch (e) {
      debugPrint('Error en resetPassword: $e');
      return 'Ocurrió un error inesperado.';
    }
  }

  void setShowLogoutMessage(bool value) {
    _shouldShowLogoutMessage = value;
  }

  void markLogoutMessageAsShown() {
    _shouldShowLogoutMessage = false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _shouldShowLogoutMessage = true;
  }
}
