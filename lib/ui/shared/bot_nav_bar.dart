import 'package:flutter/material.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5), // Đổ bóng hướng lên trên
          ),
        ],
      ),
      child: BottomNavigationBar(
        // currentIndex: 1,
        elevation: 0, // Bỏ elevation mặc định của BottomNavigationBar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_add_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
