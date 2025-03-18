import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen.dart';
import '../auth/auth_manager.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa các children trong Row
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              'TÀI KHOẢN CỦA BẠN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            LongButton(
              text: 'Chỉnh sửa email',
              icon: Icons.email_rounded,
              onPressed: () {
                Navigator.of(context).pushNamed(EditEmailScreen.routeName);
              },
            ),
            LongButton(
              text: 'Đổi mật khẩu',
              icon: Icons.security_rounded,
              onPressed: () {
                Navigator.of(context).pushNamed(EditPasswordScreen.routeName);
              },
            ),
            LongButton(
              text: 'Bộ thẻ yêu thích',
              icon: Icons.favorite,
              onPressed: () {
                Navigator.of(context).pushNamed(FavorDecksScreen.routeName);
              },
            ),
            LongButton(
              text: 'Tất cả thẻ được đánh dấu',
              icon: Icons.star_rounded,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(MarkedFlashcardsScreen.routeName);
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Chế độ",
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                ThemeButton(),
              ],
            ),
            const SizedBox(height: 40),
            WarningButton(
              text: 'Đăng xuất',
              onPressed: () {
                // Đăng xuất
                context.read<AuthManager>().logout();
                // Pop màn hình hiện tại
                Navigator.of(context).pop();
                // Sau đó push màn hình mới (không dùng replacement)
                Navigator.of(context).pushNamed('/');
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar:
          // Bottom Navigation Bar
          const BotNavBar(
        initialIndex: 2,
      ),
    );
  }
}
