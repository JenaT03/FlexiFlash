import 'package:flutter/material.dart';

import 'decks_manager.dart';
import 'deck_grid_item.dart';

class DeckGrid extends StatelessWidget {
  const DeckGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final decks = DeckManager().decks;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: decks.length,
      itemBuilder: (ctx, i) => DeckGridItem(decks[i]),
      // itemBuilder: (context, index) => DeckGridItem(decks[index]),
    );
  }
}
