import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'ui/screen.dart';
import 'package:provider/provider.dart';

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
      home: const UserDecksScreen(),
      routes: {
        AccountScreen.routeName: (ctx) => const SafeArea(
              child: AccountScreen(),
            ),
        UserDecksScreen.routeName: (ctx) => const SafeArea(
              child: UserDecksScreen(),
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == DeckDetailScreen.routeName) {
          final deckId = settings.arguments as String;
          return MaterialPageRoute(
              settings: settings,
              builder: (ctx) {
                return SafeArea(
                  child: DeckDetailScreen(
                    DeckManager().findById(deckId)!,
                  ),
                );
              });
        }
        return null;
      },
    );
  }
}
