import 'package:flutter/material.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class LoginButton extends StatefulWidget {
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
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoading = false;

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
          onPressed: isLoading
              ? null
              : () async {
                  if (!widget.formKey.currentState!.validate()) return;

                  setState(() => isLoading = true);

                  final messenger = ScaffoldMessenger.of(context);
                  final errorMessage = await authProvider.login(
                    widget.emailController.text.trim(),
                    widget.passwordController.text.trim(),
                  );

                  if (errorMessage != null) {
                    if (!context.mounted) return;

                    setState(() {
                      isLoading = false;
                    });

                    messenger.showSnackBar(
                      SnackBar(content: Text('❌ Error: $errorMessage')),
                    );
                    return;
                  }

                  final nombreCompleto = await authProvider.getUserName();
                  if (!context.mounted) return;

                  messenger.showSnackBar(
                    SnackBar(content: Text('✅ Bienvenido(a), $nombreCompleto')),
                  );

                  await Future.delayed(const Duration(seconds: 2));

                  if (!context.mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                    (route) => false,
                  );
                },
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text('Iniciar Sesión'),
        ),
      ),
    );
  }
}
