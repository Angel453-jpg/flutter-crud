import 'package:flutter/material.dart';

class ForgotPasswordController{

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSending = false;

  bool validateForm() => formKey.currentState?.validate() ?? false;

  void dispose() {
    emailController.dispose();
  }

}