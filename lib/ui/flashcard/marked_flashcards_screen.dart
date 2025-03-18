import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen.dart';

class MarkedFlashcardsScreen extends StatefulWidget {
  static const routeName = '/marked_flashcards';

  const MarkedFlashcardsScreen(this.deckId, {super.key});
  final String? deckId;

  @override
  State<MarkedFlashcardsScreen> createState() => _MarkedFlashcardsScreenState();
}

class _MarkedFlashcardsScreenState extends State<MarkedFlashcardsScreen> {
  late Future<void> _fetchFlashcards;

  void initState() {
    super.initState();
    if (widget.deckId == null) {
      _fetchFlashcards =
          context.read<FlashcardManager>().fetchMarkedFlashCards();
    } else {
      _fetchFlashcards =
          context.read<FlashcardManager>().fetchFlashCards(widget.deckId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            'THẺ ĐƯỢC ĐÁNH DẤU',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: _fetchFlashcards,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                    child: FlashcardGrid('marked', id: widget.deckId));
              }
              return const CustomProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
