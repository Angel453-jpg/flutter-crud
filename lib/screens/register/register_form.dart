import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/auth_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/controllers/register_controller.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final RegisterController controller;

  const RegisterForm({super.key, required this.controller});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: widget.controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Crear una cuenta',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: widget.controller.nameController,
            decoration: _inputDecoration('Nombre'),
            validator: (v) =>
                v == null || v.isEmpty ? 'Ingrese su nombre' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.controller.lastNameController,
            decoration: _inputDecoration('Apellido'),
            validator: (v) =>
                v == null || v.isEmpty ? 'Ingrese su apellido' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration('Correo Electrónico'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese su correo';
              final emailRegex = RegExp(r'\S+@\S+\.\S+');
              if (!emailRegex.hasMatch(value)) return 'Correo inválido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.controller.passwordController,
            obscureText: _obscurePassword,
            decoration: _inputDecoration('Contraseña').copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() {
                  _obscurePassword = !_obscurePassword;
                }),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su contraseña';
              }
              if (value.length < 8) return 'Mínimo 8 caracteres';
              return null;
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (!widget.controller.validateForm()) return;

                final errorMessage = await authProvider.register(
                  email: widget.controller.emailController.text.trim(),
                  password: widget.controller.passwordController.text.trim(),
                  nombre: widget.controller.nameController.text.trim(),
                  apellido: widget.controller.lastNameController.text.trim(),
                );

                if (errorMessage != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('❌ Error: $errorMessage')),
                  );
                  return;
                }

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Cuenta creada exitosamente'),
                    ),
                  );
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }
              },
              style: _buttonStyle(),
              child: const Text('Registrar'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Regresar'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              style: _buttonStyle(),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  );

  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
