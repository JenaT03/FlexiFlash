import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen.dart';
import '../../models/flashcard.dart';

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
    final flashManager = context.read<FlashcardManager>();
    flashManager.setOnDeleteFunction(_showConfirmDeleteFlashcardDialog);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              DeckDetailScreen.routeName,
              arguments: widget.deckId,
              (route) => false,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              Navigator.of(context).pushNamed(
                AddFlashCardScreen.routeName,
                arguments: {'deckId': widget.deckId},
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  return Expanded(
                      child: FlashcardGrid(id: widget.deckId, 'edit'));
                }
                return CustomProgressIndicator();
              }),
        ],
      ),
    );
  }

  Future<void> _deleteFlashCard(String flashcardId, String deckId) async {
    try {
      final flashcardManager = context.read<FlashcardManager>();
      await flashcardManager.deleteFlashcard(flashcardId, deckId);
      return;
    } catch (error) {
      await showErrorDialog(context, 'Có lỗi xảy ra');
    }
  }

  Future<void> _showConfirmDeleteFlashcardDialog(
      BuildContext context, Flashcard? flashcard) async {
    if (flashcard == null) return;
    final errorColor = Theme.of(context).colorScheme.error;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Xác nhận xóa',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: errorColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              'Bạn có chắc muốn xóa thẻ "${flashcard.text}" không? 🤔',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustTextButton(
                text: "Hủy",
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              CustFilledButton(
                text: "Xóa",
                onPressed: () async {
                  Navigator.of(ctx).pop();

                  try {
                    await _deleteFlashCard(flashcard.id!, flashcard.deckId);
                    Navigator.of(context).pushReplacementNamed(
                      EditFlashcardListScreen.routeName,
                      arguments: flashcard.deckId,
                    );
                  } catch (error) {
                    await showErrorDialog(context, 'Có lỗi xảy ra');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
