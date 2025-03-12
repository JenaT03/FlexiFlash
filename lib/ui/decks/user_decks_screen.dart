import 'package:flutter/material.dart';

import '../shared/bot_nav_bar.dart';
import '../shared/long_button.dart';
import 'deck_grid.dart';
import 'add_deck_screen.dart';

class UserDecksScreen extends StatelessWidget {
  static const routeName = '/user_decks';

  const UserDecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFFFF9431),
        title: Center(
          // Wrap Row trong Center widget
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa các children trong Row
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Orange "Create new card" button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LongButton(
              text: 'Tạo bộ thẻ mới',
              icon: Icons.my_library_add_rounded,
              onPressed: () {
                Navigator.of(context).pushNamed(AddDeckScreen.routeName);
              },
            ),
          ),

          // "Your cards" title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'BỘ THẺ CỦA BẠN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Scrollable grid of cards
          Expanded(
            child: DeckGrid(),
          ),
        ],
      ),
      bottomNavigationBar:
          // Bottom Navigation Bar
          const BotNavBar(initialIndex: 0),
    );
  }
}
