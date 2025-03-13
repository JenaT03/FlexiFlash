import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/deck.dart';
import '../screen.dart';

class EditDeckScreen extends StatelessWidget {
  final String deckId;
  const EditDeckScreen({super.key, required this.deckId});

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
      body: Column(),
    );
  }
}
