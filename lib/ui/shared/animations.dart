import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animations/loading.json',
          width: 200,
          height: 200,
          repeat: true,
        ),
        Text('Đang tải...')
      ],
    ));
  }
}
