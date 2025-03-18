import 'package:flutter/material.dart';

class ShortButton extends StatelessWidget {
  const ShortButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
  });

  final String text;
  final void Function()? onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Center(
        // Wrap với Center widget
        child: SizedBox(
          width: 160, // Đặt chiều rộng cố định
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDisabled
                  ? Colors.grey // Màu xám khi disable
                  : Theme.of(context).colorScheme.secondary,
              foregroundColor: isDisabled
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSecondary,
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
