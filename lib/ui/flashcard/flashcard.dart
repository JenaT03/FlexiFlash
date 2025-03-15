import 'package:ct484_project/ui/screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../models/flashcard.dart';
import 'flashcards_manager.dart';

class FlashCard extends StatelessWidget {
  const FlashCard(this.flashcard, {super.key});
  final Flashcard flashcard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 56.0),
      child: Container(
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 10,
              offset: Offset(1, 2),
              spreadRadius: 1,
            )
          ],
        ),
        child: Consumer<FlashcardManager>(
          builder: (context, flashcardManager, child) {
            final updatedFlashcard =
                flashcardManager.findById(flashcard.id!) ?? flashcard;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => {
                          Navigator.of(context).pushNamed(
                            FlashCardDetail.routeName,
                            arguments: flashcard.id,
                          )
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Mô tả chi tiết',
                            style: TextStyle(
                              fontStyle: FontStyle.italic, // Chữ nghiêng
                              decoration: TextDecoration.underline, // Gạch dưới
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground, // Màu xanh giống như link
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          flashcardManager.updateFlashcard(
                            updatedFlashcard.copyWith(
                                isMarked: !updatedFlashcard.isMarked),
                            updatedFlashcard.deckId,
                          );
                        },
                        icon: Icon(
                          updatedFlashcard.isMarked
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 220,
                  height: 200,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(updatedFlashcard.imgURL),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.0,
                    right: 24.0,
                    left: 24.0,
                    bottom: 28.0,
                  ),
                  child: Text(
                    updatedFlashcard.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
