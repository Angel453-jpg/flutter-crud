import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/auth_provider.dart';
import 'package:flutter_crud/screens/login/login_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _opacity = 1);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.shouldShowLogoutMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(
          const SnackBar(content: Text('✅ Sesión cerrada correctamente')),
        );
        authProvider.markLogoutMessageAsShown();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey]
                : [Colors.white, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 500),
          child: const Center(child: SingleChildScrollView(child: LoginForm())),
        ),
      ),
    );
  }
}
