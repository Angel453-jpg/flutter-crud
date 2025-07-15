import 'package:flutter/material.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;

            final messenger = ScaffoldMessenger.of(context);
            final success = await authProvider.login(
              emailController.text.trim(),
              passwordController.text.trim(),
            );

            if (!success) {
              if (!context.mounted) return;
              messenger.showSnackBar(
                const SnackBar(content: Text('❌ Error al iniciar sesión')),
              );
              return;
            }

            final nombreCompleto = await authProvider.getUserName();
            if (!context.mounted) return;

            messenger.showSnackBar(
              SnackBar(content: Text('✅ Bienvenido(a), $nombreCompleto')),
            );
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
          child: const Text('Iniciar Sesión'),
        ),
      ),
    );
  }
}
