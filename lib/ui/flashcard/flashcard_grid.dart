import 'package:flutter/material.dart';
import 'flashcards_manager.dart';
import 'flashcard_grid_item.dart';

class FlashcardGrid extends StatelessWidget {
  const FlashcardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final flashcards = FlashcardManager().flashcards;

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
