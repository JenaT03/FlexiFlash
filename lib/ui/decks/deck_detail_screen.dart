import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/deck.dart';
import '../screen.dart';

class DeckDetailScreen extends StatefulWidget {
  static const routeName = '/deck_detail';

  const DeckDetailScreen(this.deck, {super.key});

  final Deck deck;

  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 36,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Stack(
            children: [
              Container(
                width: 355,
                height: 210,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.deck.imageBg),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFDEDADA)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                  right: 5,
                  child: FavorButton(
                    deck: widget.deck,
                  )),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              widget.deck.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: LongButton(
              text: 'Xem tất cả thẻ',
              icon: Icons.auto_awesome_motion,
              onPressed: () {
                print('id widget ${widget.deck.id}');
                Navigator.of(context).pushNamed(
                  FlashcardScreen.routeName,
                  arguments: widget.deck.id,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 18.0, left: 18.0),
            child: LongButton(
              text: 'Xem tất cả thẻ được đánh dấu',
              icon: Icons.star_rounded,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  MarkedFlashcardsScreen.routeName,
                  arguments: widget.deck.id,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 18.0, left: 18.0),
            child: LongButton(
              text: 'Câu hỏi hình ảnh',
              icon: Icons.question_mark_rounded,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Quiz.routeName,
                  arguments: widget.deck.id,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShortButton(
                text: "Sửa bộ thẻ",
                onPressed: () => {
                  Navigator.of(context).pushNamed(
                    AddDeckScreen.routeName,
                    arguments: widget.deck.id,
                  )
                },
              ),
              WarningButton(
                text: "Xóa bộ thẻ",
                onPressed: () async {
                  if (mounted) {
                    await showConfirmDialog(context, widget.deck);
                  }
                },
              )
            ],
          )
        ],
      ),
      bottomNavigationBar:
          // Bottom Navigation Bar
          const BotNavBar(initialIndex: 0),
    );
  }

  Future<void> _deleteDeck(Deck? deck) async {
    if (deck == null) return;
    final deckManager = context.read<DecksManager>();

    try {
      await deckManager.deleteDeck(deck.id!);
      return;
    } catch (error) {
      if (mounted) {
        await showErrorDialog(context, 'Có lỗi xảy ra');
      }
    }
  }

  Future<void> showConfirmDialog(BuildContext context, Deck? deck) async {
    if (deck == null) return;

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
              'Bạn có chắc muốn xóa bộ thẻ "${deck.title}" không? 🤔',
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
                    await _deleteDeck(deck);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      DecksOverviewScreen.routeName,
                      (route) => false,
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

class FavorButton extends StatelessWidget {
  const FavorButton({super.key, required this.deck});

  final Deck deck;

  @override
  Widget build(BuildContext context) {
    return Consumer<DecksManager>(
      builder: (context, decksManager, child) {
        final updatedDeck = decksManager.findById(deck.id!) ?? deck;

        return ElevatedButton.icon(
          onPressed: () {
            decksManager.updateDeck(
              updatedDeck.copyWith(isFavorite: !updatedDeck.isFavorite),
            );
          },
          icon: Icon(
            updatedDeck.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: updatedDeck.isFavorite
                ? Colors.white
                : Theme.of(context).colorScheme.secondary,
          ),
          label: Text(
            "Yêu thích",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: updatedDeck.isFavorite
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: updatedDeck.isFavorite
                ? Theme.of(context).colorScheme.secondary
                : const Color.fromARGB(78, 253, 253, 253),
            side: BorderSide(
              color: updatedDeck.isFavorite
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
        );
      },
    );
  }
}
