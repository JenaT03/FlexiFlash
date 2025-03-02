import 'package:flutter/material.dart';

import '../../models/deck.dart';

class DeckGridItem extends StatelessWidget {
  const DeckGridItem(
    this.deck, {
    super.key,
  });

  final Deck deck;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 137,
      height: 164,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFDEDADA)),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    deck.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          Container(
            width: 140,
            height: 130,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(deck.imageBg),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
