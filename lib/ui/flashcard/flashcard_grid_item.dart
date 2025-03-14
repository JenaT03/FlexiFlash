import 'package:flutter/material.dart';

import '../../models/flashcard.dart';

class FlashcardGridItem extends StatelessWidget {
  const FlashcardGridItem(
    this.flashcard, {
    super.key,
  });

  final Flashcard flashcard;

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
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              flashcard.text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: 140,
            height: 120,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(flashcard.imgURL),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
              ),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          )
        ],
      ),
    );
  }
}
