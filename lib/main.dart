import 'package:flutter/material.dart';

import 'screen/login_page.dart';

void main() {
  runApp(const MakananApp());
}

class MakananApp extends StatelessWidget {
  const MakananApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF285943);
    return MaterialApp(
      title: 'Rasa Rumah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          secondary: const Color(0xFFE7784A),
          surface: const Color(0xFFFFFEFA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F6EF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F6EF),
          foregroundColor: Color(0xFF20382D),
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE1E4DA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE1E4DA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: forest, width: 1.6),
          ),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
