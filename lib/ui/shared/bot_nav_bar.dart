import 'package:ct484_project/ui/screen.dart';
import 'package:flutter/material.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({super.key});

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _currentIndex = 1; // Mặc định chọn Home

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed(UserDecksScreen.routeName);
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(UserDecksScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(AccountScreen.routeName);
        break;
    }
  }

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
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        elevation: 0, // Bỏ elevation mặc định của BottomNavigationBar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 30,
              color: Color(0xFF919191),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Color(0xFF919191),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
              color: Color(0xFF919191),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
