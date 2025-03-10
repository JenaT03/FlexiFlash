import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'ui/screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'FlexiFlash',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            home: authManager.isAuth
                ? const SafeArea(child: DecksOverviewScreen())
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SafeArea(child: SplashScreen())
                          : const SafeArea(child: AuthScreen());
                    },
                  ),
            routes: {
              AccountScreen.routeName: (ctx) => const SafeArea(
                    child: AccountScreen(),
                  ),
              UserDecksScreen.routeName: (ctx) => const SafeArea(
                    child: UserDecksScreen(),
                  ),
              DecksOverviewScreen.routeName: (ctx) => const SafeArea(
                    child: DecksOverviewScreen(),
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
                          DecksManager().findById(deckId)!,
                        ),
                      );
                    });
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
