import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen.dart';
import 'deck_grid.dart';

class DecksFavorScreen extends StatefulWidget {
  static const routeName = '/favorite_decks';
  const DecksFavorScreen({super.key});

  @override
  State<DecksFavorScreen> createState() => _DecksFavorScreenState();
}

class _DecksFavorScreenState extends State<DecksFavorScreen> {
  late Future<void> _fetchDecks;

  @override
  void initState() {
    super.initState();
    _fetchDecks = context.read<DecksManager>().fetchDecks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            'BỘ THẺ YÊU THÍCH CỦA BẠN',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FutureBuilder(
              future: _fetchDecks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: DeckGrid('Yêu thích'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ],
      ),
      bottomNavigationBar: const BotNavBar(initialIndex: 1),
    );
  }
}
