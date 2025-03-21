import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return FlutterSwitch(
      width: 70,
      height: 35,
      toggleSize: 30,
      value: isDark,
      borderRadius: 20,
      activeColor: Theme.of(context).colorScheme.secondaryFixedDim,
      inactiveColor: Colors.grey.shade300,
      activeIcon: const Icon(Icons.dark_mode, color: Colors.yellow),
      inactiveIcon: const Icon(Icons.light_mode, color: Colors.orange),
      onToggle: (value) {
        // Thêm tham số `value`
        themeProvider.toggleTheme(value);
      },
    );
    // return IconButton(
    //   icon: Icon(
    //     isDark ? Icons.toggle_off_outlined : Icons.toggle_on,
    //     color: Theme.of(context).colorScheme.onSurface,
    //     size: 30,
    //   ),
    //   onPressed: () => changeThemeMode(!isDark),
    // );
  }
}
