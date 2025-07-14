import 'package:flutter/material.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validateForm() => formKey.currentState?.validate() ?? false;

  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
