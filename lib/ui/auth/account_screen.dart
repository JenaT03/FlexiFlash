import 'package:flutter/material.dart';
import '../shared/short_button.dart';
import '../shared/long_button.dart';
import '../shared/bot_nav_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'TÀI KHOẢN CỦA BẠN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            LongButton(
              text: 'Chỉnh sửa tài khoản',
              icon: Icons.edit,
              onPressed: () {},
            ),
            LongButton(
              text: 'Bộ thẻ yêu thích',
              icon: Icons.favorite,
              onPressed: () {},
            ),
            LongButton(
              text: 'Bộ thẻ của bạn',
              icon: Icons.school,
              onPressed: () {},
            ),
            const SizedBox(height: 40),
            ShortButton(
              text: 'Đăng xuất',
              onPressed: () {},
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar:
          // Bottom Navigation Bar
          const BotNavBar(),
    );
  }
}
