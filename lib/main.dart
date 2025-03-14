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
        ChangeNotifierProvider(
          create: (ctx) => DecksManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FlashcardManager(),
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
                          ctx.read<DecksManager>().findById(deckId)!,
                        ),
                      );
                    });
              }
              if (settings.name == AddDeckScreen.routeName) {
                final deckId = settings.arguments as String?;
                return MaterialPageRoute(
                    settings: settings,
                    builder: (ctx) {
                      return SafeArea(
                        child: AddDeckScreen(
                          deckId != null
                              ? ctx.read<DecksManager>().findById(deckId)
                              : null,
                        ),
                      );
                    });
              }

              if (settings.name == AddFlashCardScreen.routeName) {
                final arguments = settings.arguments as Map<String, dynamic>?;

                final String? flashcardId = arguments!['flashcardId'];
                final String deckId = arguments['deckId'];
                return MaterialPageRoute(
                    settings: settings,
                    builder: (ctx) {
                      return SafeArea(
                        child: AddFlashCardScreen(
                          deckId: deckId,
                          flashcardId != null
                              ? ctx
                                  .read<FlashcardManager>()
                                  .findById(flashcardId)
                              : null,
                        ),
                      );
                    });
              }

              if (settings.name == EditFlashcardListScreen.routeName) {
                final deckId = settings.arguments as String;
                return MaterialPageRoute(
                    settings: settings,
                    builder: (ctx) {
                      return SafeArea(
                        child: EditFlashcardListScreen(
                          deckId: deckId,
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
