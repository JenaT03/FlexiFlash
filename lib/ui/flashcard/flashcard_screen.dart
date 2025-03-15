import 'package:flutter/material.dart';
import '../screen.dart';
import '../../models/flashcard.dart';
import 'package:provider/provider.dart';

class FlashcardScreen extends StatefulWidget {
  static const routeName = '/flashcard';

  final String deckId;

  const FlashcardScreen({
    super.key,
    required this.deckId,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late Future<List<Flashcard>> _flashcardsFuture;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _flashcardsFuture =
        context.read<FlashcardManager>().getFlashcardsByDeck(widget.deckId);
  }

  void _nextFlashcard(List<Flashcard> flashcards) {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
    });
  }

  void _previousFlashcard(List<Flashcard> flashcards) {
    setState(() {
      currentIndex = (currentIndex - 1 + flashcards.length) % flashcards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcardManager = context.read<FlashcardManager>();
    final deck = context.read<DecksManager>().findById(widget.deckId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            flashcardManager.stop(); // Dừng TTS khi quay lại
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                'assets/images/logo.png',
                height: 36,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Flashcard>>(
        future: _flashcardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Không có flashcard nào"));
          }

          List<Flashcard> flashcards = snapshot.data!;
          final flashcard = flashcards[currentIndex];

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  deck?.title ?? "Flashcards",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Thẻ thứ ${currentIndex + 1} / ${flashcards.length}'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FlashCard(flashcard),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        flashcardManager.stop();
                        _previousFlashcard(flashcards);
                      },
                      icon: Icon(Icons.arrow_back_ios_rounded, size: 50),
                    ),
                    IconButton(
                      onPressed: () => flashcardManager.speak(flashcard),
                      icon: Icon(Icons.volume_up_rounded, size: 50),
                    ),
                    IconButton(
                      onPressed: () {
                        flashcardManager.stop();
                        _nextFlashcard(flashcards);
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded, size: 50),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
