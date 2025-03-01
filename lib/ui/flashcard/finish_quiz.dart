import 'package:flutter/material.dart';
import '../screen.dart';

class FinishQuiz extends StatelessWidget {
  const FinishQuiz({super.key});

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hoàn thành!!!",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.inverseSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Số câu đúng:",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16),
                  ),
                ],
              ),
              Text(
                "12 câu",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.cancel,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  Text(
                    "Số câu sai:",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16),
                  ),
                ],
              ),
              Text(
                "12 câu",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 40),
          Text(
            "Trở về",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShortButton(
                text: "Bộ thẻ",
                onPressed: () => {},
              ),
              ShortButton(
                text: "Trang chủ",
                onPressed: () => {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
