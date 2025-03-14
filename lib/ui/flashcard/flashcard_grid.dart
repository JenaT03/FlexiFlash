import 'package:ct484_project/models/flashcard.dart';
import 'package:ct484_project/ui/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flashcards_manager.dart';
import 'flashcard_grid_item.dart';

class FlashcardGrid extends StatelessWidget {
  final String id;
  const FlashcardGrid(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final flashcards = context.select<FlashcardManager, List<Flashcard>>(
        (flashcardManager) => id.isNotEmpty
            ? flashcardManager.flashcards
                .where((flashcard) => flashcard.deckId == id)
                .toList()
            : []);
    if (flashcards.isEmpty) {
      return const Center(child: Text('Không có thẻ nào.'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: flashcards.length,
      itemBuilder: (ctx, i) => FlashcardGridItem(flashcards[i]),
      // itemBuilder: (context, index) => FlashcardGridItem(flashcards[index]),
    );
  }
}
