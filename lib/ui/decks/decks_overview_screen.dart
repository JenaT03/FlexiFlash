import 'package:flutter/material.dart';

import '../shared/bot_nav_bar.dart';
import 'deck_grid.dart';

class DecksOverviewScreen extends StatelessWidget {
  const DecksOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'TẤT CẢ BỘ THẺ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(), // Đẩy nút menu về bên phải
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Tìm kiếm...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Theme.of(context).colorScheme.surface),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: DeckGrid(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavBar(),
    );
  }
}
