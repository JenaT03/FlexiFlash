import 'package:flutter/material.dart';

import '../../models/deck.dart';
import '../screen.dart';

class DeckDetailScreen extends StatelessWidget {
  static const routeName = '/deck_detail';

  const DeckDetailScreen(this.deck, {super.key});

  final Deck deck;

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
                    image: NetworkImage(deck.imageBg),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFDEDADA)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () => {},
                  icon: FavorIcon(deck),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              deck.title,
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
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 18.0, left: 18.0),
            child: LongButton(
              text: 'Xem tất cả thẻ yêu thích',
              icon: Icons.favorite,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 18.0, left: 18.0),
            child: LongButton(
              text: 'Trắc nghiệm hình ảnh',
              icon: Icons.ads_click,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShortButton(
                text: "Sửa bộ thẻ",
                onPressed: () => {},
              ),
              WarningButton(
                text: "Xóa bộ thẻ",
                onPressed: () => {},
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
}

class FavorIcon extends StatefulWidget {
  const FavorIcon(
    this.deck, {
    super.key,
  });

  final Deck deck;

  @override
  State<FavorIcon> createState() => _FavorIconState();
}

class _FavorIconState extends State<FavorIcon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          widget.deck.isFavorite = !widget.deck.isFavorite;
        });
      },
      icon: Icon(
        widget.deck.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: widget.deck.isFavorite
            ? Colors.white
            : Theme.of(context).colorScheme.secondary,
      ),
      label: Text(
        "Yêu thích",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: widget.deck.isFavorite
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          fontSize: 12,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0, // Không đổ bóng
        backgroundColor: widget.deck.isFavorite
            ? Theme.of(context).colorScheme.secondary
            : const Color.fromARGB(78, 253, 253, 253),
        side: BorderSide(
          color: widget.deck.isFavorite
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
  }
}
