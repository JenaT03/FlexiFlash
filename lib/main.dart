import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'ui/screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'models/flashcard.dart';

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
              FavorDecksScreen.routeName: (ctx) => const SafeArea(
                    child: FavorDecksScreen(),
                  ),
            },
            onGenerateRoute: (settings) {
              if (settings.name == DeckDetailScreen.routeName) {
                final deckId = settings.arguments as String;
                return PageScaleTransition(
                  settings: settings,
                  page: DeckDetailScreen(
                    ctx.read<DecksManager>().findById(deckId)!,
                  ),
                );
              }
              if (settings.name == AddDeckScreen.routeName) {
                final deckId = settings.arguments as String?;
                return PageScaleTransition(
                  settings: settings,
                  page: AddDeckScreen(
                    deckId != null
                        ? ctx.read<DecksManager>().findById(deckId)
                        : null,
                  ),
                );
              }

              if (settings.name == AddFlashCardScreen.routeName) {
                final arguments = settings.arguments as Map<String, dynamic>?;
                final String deckId = arguments!['deckId'];
                final String? flashcardId = arguments['flashcardId'];

                return PageFromRightTransition(
                  settings: settings,
                  page: AddFlashCardScreen(
                    deckId: deckId,
                    flashcardId != null
                        ? ctx.read<FlashcardManager>().findById(flashcardId)
                        : null,
                  ),
                );
              }

              if (settings.name == EditFlashcardListScreen.routeName) {
                final deckId = settings.arguments as String;
                return PageFromLeftTransition(
                  settings: settings,
                  page: EditFlashcardListScreen(
                    deckId: deckId,
                  ),
                );
              }

              if (settings.name == FlashcardScreen.routeName) {
                final deckId = settings.arguments as String?;

                if (deckId == null) {
                  return MaterialPageRoute(
                    builder: (ctx) => Scaffold(
                      body: Center(
                          child: Text("Lỗi: Không tìm thấy bộ thẻ này! 🧐")),
                    ),
                  );
                }

                return PageScaleTransition(
                  settings: settings,
                  page: FlashcardScreen(deckId: deckId),
                );
              }

              if (settings.name == FlashCardDetail.routeName) {
                final flashcardId = settings.arguments as String;

                return PageScaleTransition(
                  settings: settings,
                  page: FlashCardDetail(
                    flashcard:
                        ctx.read<FlashcardManager>().findById(flashcardId)!,
                  ),
                );
              }

              if (settings.name == MarkedFlashcardsScreen.routeName) {
                final deckId = settings.arguments as String;
                return PageScaleTransition(
                  settings: settings,
                  page: MarkedFlashcardsScreen(deckId),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
