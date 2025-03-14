import 'package:ct484_project/ui/flashcard/add_flashcard_screen.dart';
import 'package:ct484_project/ui/flashcard/flashcards_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flashcard_grid.dart';

class EditFlashcardListScreen extends StatefulWidget {
  static const routeName = '/edit_flashcard_list';
  const EditFlashcardListScreen({super.key, required this.deckId});

  final String deckId;

  @override
  State<EditFlashcardListScreen> createState() =>
      _EditFlashcardListScreenState();
}

class _EditFlashcardListScreenState extends State<EditFlashcardListScreen> {
  late Future<void> _fetchFlashcards;
  @override
  void initState() {
    super.initState();
    _fetchFlashcards =
        context.read<FlashcardManager>().fetchFlashCards(widget.deckId);
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
          actions: <Widget>[
            IconButton(
              onPressed: () => {
                Navigator.of(context).pushNamed(
                  AddFlashCardScreen.routeName,
                  arguments: widget.deckId,
                )
              },
              icon: Icon(
                Icons.my_library_add_outlined,
                size: 30,
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'CHỈNH SỬA THẺ',
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
                    return Expanded(child: FlashcardGrid(widget.deckId));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ));
  }
}
