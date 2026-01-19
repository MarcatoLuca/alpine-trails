import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/services/domain/auth.service.dart';
import 'package:provider/provider.dart';

enum AuthMode { welcome, login, register }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.welcome;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  void _switchMode(AuthMode mode) {
    setState(() => _authMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. IMMAGINE DI SFONDO A TUTTO SCHERMO
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=2070&auto=format&fit=crop',
                ), // Placeholder per la tua immagine
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. OVERLAY SFUMATO
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),

          // 3. CONTENUTO
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // LOGO IN ALTO
                const Icon(
                  Icons.terrain_rounded,
                  size: 80,
                  color: Colors.white,
                ),
                const Text(
                  "ALPINE TRAILS",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                // AREA INTERATTIVA (BOTTONI O FORM)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ), // Effetto vetro sfocato
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child:
                            _authMode == AuthMode.welcome
                                ? _buildWelcomeSection()
                                : _buildFormSection(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      key: const ValueKey('welcome'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "L'avventura ti aspetta",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Unisciti alla community di escursionisti",
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
        const SizedBox(height: 32),
        _buildButton(
          "ACCEDI",
          () => _switchMode(AuthMode.login),
          isPrimary: true,
        ),
        const SizedBox(height: 16),
        _buildButton(
          "REGISTRATI",
          () => _switchMode(AuthMode.register),
          isPrimary: false,
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return SingleChildScrollView(
      key: ValueKey(_authMode),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => _switchMode(AuthMode.welcome),
                ),
                Text(
                  _authMode == AuthMode.login ? "Accedi" : "Registrati",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (_authMode == AuthMode.register) ...[
              _buildInput(_firstNameController, "Nome", Icons.person_outline),
              const SizedBox(height: 12),
              _buildInput(_lastNameController, "Cognome", Icons.person_outline),
              const SizedBox(height: 12),
            ],

            _buildInput(_emailController, "Email", Icons.email_outlined),
            const SizedBox(height: 12),
            _buildInput(
              _passwordController,
              "Password",
              Icons.lock_outline,
              isPassword: true,
            ),

            const SizedBox(height: 24),
            _buildButton(
              _isLoading ? "CARICAMENTO..." : "CONFERMA",
              _isLoading ? null : _submit,
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }

  // Helper per i campi Input in stile "Glass"
  Widget _buildInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed:
                      () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                )
                : null,
      ),
    );
  }

  // Helper per i Bottoni
  Widget _buildButton(
    String text,
    VoidCallback? onPressed, {
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.brown : Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          side:
              isPrimary
                  ? BorderSide.none
                  : const BorderSide(color: Colors.white, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      if (_authMode == AuthMode.login) {
        await authService.login(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } else {
        await authService.register(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      }

      if (!mounted) return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Errore durante il login. Controlla le credenziali.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
