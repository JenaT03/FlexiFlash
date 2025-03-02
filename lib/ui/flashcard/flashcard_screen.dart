import 'package:flutter/material.dart';
import '../screen.dart';

class FlashcardScreen extends StatelessWidget {
  static const routeName = '/flashcard';

  const FlashcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Nấm độc tại rừng quốc gia Việt Nam',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 40),
          FlashCard(),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.volume_up_rounded,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 50,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
