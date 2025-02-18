import 'package:flutter/material.dart';
import 'ui/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Color.fromARGB(255, 255, 153, 19),
      secondary: Color.fromARGB(255, 255, 198, 123),
      surface: Colors.white,
    );
    final themeData = ThemeData(
      fontFamily: 'Inter',
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shadowColor: colorScheme.shadow,
      ),
    );
    return MaterialApp(
      title: 'FlexiFlash',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const Login(),
    );
  }
}
