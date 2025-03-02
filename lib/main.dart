import 'package:ct484_project/ui/decks/add_deck_screen.dart';
import 'package:ct484_project/ui/decks/decks_overview_screen.dart';
import 'package:ct484_project/ui/flashcard/add_flashcard_screen.dart';
import 'package:flutter/material.dart';
import 'ui/screen.dart';
import 'package:provider/provider.dart';
import 'models/deck.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'FlexiFlash',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      home: AccountScreen(),
    );
  }
}
