import 'package:ct484_project/ui/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/flashcard.dart';

class FlashcardGridItem extends StatelessWidget {
  const FlashcardGridItem(
    this.flashcard, {
    super.key,
  });

  final Flashcard flashcard;

  @override
  Widget build(BuildContext context) {
    final flashManager = context.read<FlashcardManager>();
    return Container(
      width: 137,
      height: 165,
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
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    context.read<FlashcardManager>().updateFlashcard(
                          flashcard.copyWith(isMarked: !flashcard.isMarked),
                          flashcard.deckId,
                        ),
                  },
                  icon: Icon(
                    flashcard.isMarked
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: 130,
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
          ),
          const SizedBox(height: 5),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => {
                  Navigator.of(context).pushNamed(AddFlashCardScreen.routeName,
                      arguments: {
                        'deckId': flashcard.deckId,
                        'flashcardId': flashcard.id
                      }),
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
              ),
              IconButton(
                onPressed: () => {
                  if (flashManager.onDeleteFlashcard != null)
                    {flashManager.onDeleteFlashcard!(context, flashcard)}
                },
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
