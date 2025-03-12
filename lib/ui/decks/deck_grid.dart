import 'package:flutter/material.dart';

import 'decks_manager.dart';
import 'deck_grid_item.dart';
import 'package:provider/provider.dart';
import '../../models/deck.dart';
import '../../models/user.dart';
import '../auth/auth_manager.dart';

enum FilterOptions { all, sinhhoc, vatly, hoahoc, lichsu, dialy }

class DeckGrid extends StatelessWidget {
  final String text;
  final bool isSearch;
  const DeckGrid(this.text, {super.key, this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    User? user = context.read<AuthManager>().user;
    final decks = context.select<DecksManager, List<Deck>>(
      (deckManager) {
        if (text.isEmpty) {
          return deckManager.decks;
        }
        if (isSearch) {
          return deckManager.decks
              .where((deck) =>
                  deck.title.toLowerCase().contains(text.toLowerCase()))
              .toList();
        }
        if (text == 'yours') {
          return deckManager.decks
              .where((deck) => deck.userId == user!.id!)
              .toList();
        } else {
          return deckManager.decks.where((deck) => deck.type == text).toList();
        }
      },
    ); // Lắng nghe thay đổi

    if (decks.isEmpty) {
      return const Center(child: Text('Không có bộ thẻ nào.'));
    }

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
