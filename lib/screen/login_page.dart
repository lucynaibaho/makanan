import 'package:flutter/material.dart';

import 'root_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _usernameInvalid = false;
  bool _passwordInvalid = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final usernameValid = username.toLowerCase() == 'lucy naibaho';
    final passwordValid = password == '124240040';

    setState(() {
      _usernameInvalid = !usernameValid;
      _passwordInvalid = !passwordValid;
    });

    if (!usernameValid || !passwordValid) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Username atau password tidak sesuai.'),
            backgroundColor: Color(0xFFB64036),
          ),
        );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) =>
            const RootPage(studentName: 'Lucy Naibaho', studentId: '124240040'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF285943),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                  const SizedBox(height: 34),
                  Text(
                    'Rasa Rumah',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color(0xFF20382D),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Masuk untuk menikmati menu hari ini.',
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: const Color(0xFF68756D)),
                  ),
                  const SizedBox(height: 34),
                  TextField(
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) {
                      if (_usernameInvalid) {
                        setState(() => _usernameInvalid = false);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email / Username',
                      prefixIcon: const Icon(Icons.person_outline),
                      errorText: _usernameInvalid
                          ? 'Username tidak valid'
                          : null,
                      errorBorder: _errorBorder,
                      focusedErrorBorder: _errorBorder,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onSubmitted: (_) => _login(),
                    onChanged: (_) {
                      if (_passwordInvalid) {
                        setState(() => _passwordInvalid = false);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      errorText: _passwordInvalid
                          ? 'Password tidak valid'
                          : null,
                      errorBorder: _errorBorder,
                      focusedErrorBorder: _errorBorder,
                      suffixIcon: IconButton(
                        tooltip: _obscurePassword
                            ? 'Tampilkan password'
                            : 'Sembunyikan password',
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: _login,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF285943),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final _errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(color: Color(0xFFB64036), width: 1.5),
);
