import 'package:ct484_project/models/deck.dart';
import 'package:ct484_project/models/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen.dart';

class FlashCardDetail extends StatelessWidget {
  static const routeName = '/flashcard_detail';

  const FlashCardDetail({super.key, required this.flashcard});

  final Flashcard flashcard;
  @override
  Widget build(BuildContext context) {
    final Deck? deck = context.read<DecksManager>().findById(flashcard.deckId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<FlashcardManager>().stop(); // Dừng TTS khi quay lại
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                'assets/images/logo.png',
                height: 36,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                child: Text(
                  deck != null ? deck.title : 'Lỗi không thể hiện tên bộ thẻ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                flashcard.text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Ảnh minh họa",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Giữ bo góc
                  child: Image.network(flashcard.imgURL),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mô tả chi tiết",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  IconButton(
                    onPressed: () => context
                        .read<FlashcardManager>()
                        .speak(flashcard, flashcard.description),
                    icon: Icon(Icons.volume_up_rounded, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                flashcard.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
