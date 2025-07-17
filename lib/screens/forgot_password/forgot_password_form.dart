import 'package:flutter/material.dart';
import 'package:flutter_crud/controllers/forgot_password_controller.dart';
import 'package:flutter_crud/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final controller = ForgotPasswordController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    if (!controller.validateForm()) return;

    setState(() => controller.isSending = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final errorMessage = await authProvider.resetPassword(
      controller.emailController.text.trim(),
    );

    if (!mounted) return;

    if (errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ $errorMessage')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '📩 Si el correo está registrado, recibirás un enlace para restablecer tu contraseña.',
          ),
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }

    setState(() => controller.isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Card(
        elevation: 12,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Recuperar Contraseña',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Ingresa tu correo para restablecer tu contraseña',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un correo electrónico';
                    }
                    final emailRegex = RegExp(r'\S+@\S+\.\S+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Correo inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isSending
                        ? null
                        : _handlePasswordReset,
                    style: _buttonStyle(),
                    child: controller.isSending
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Enviar Correo de Recuperación'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    ),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Volver al inicio de sesión'),
                    style: _buttonStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
