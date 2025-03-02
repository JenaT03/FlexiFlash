import 'package:ct484_project/models/deck.dart';
import 'package:flutter/material.dart';
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
          const SizedBox(height: 30),
          Container(
            width: 355,
            height: 210,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1561999564-f49468bc7a93?q=80&w=1933&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFDEDADA)),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
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
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: LongButton(
              text: 'Xem tất cả thẻ',
              icon: Icons.auto_awesome_motion,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
            child: LongButton(
              text: 'Ghép thẻ',
              icon: Icons.polyline_rounded,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
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
          const BotNavBar(),
    );
  }
}
