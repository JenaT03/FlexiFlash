import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  final primaryColor = Theme.of(context).colorScheme.primary;

  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Xác nhận',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustFilledButton(
              text: 'Hủy',
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.error),
      title: const Text('An Error Occurred!'),
      content: Text(message),
      actions: <Widget>[
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.actionText,
    this.onPressed,
  });

  final String? actionText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        actionText ?? 'Okay',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 24,
            ),
      ),
    );
  }
}

class CustFilledButton extends StatelessWidget {
  const CustFilledButton({
    super.key,
    this.text,
    this.onPressed,
  });

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final onSecondaryColor = Theme.of(context).colorScheme.onSecondary;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
      onPressed: onPressed,
      child: Text(text ?? 'Ok', style: TextStyle(color: onSecondaryColor)),
    );
  }
}

class CustTextButton extends StatelessWidget {
  const CustTextButton({
    super.key,
    this.text,
    this.onPressed,
  });

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return TextButton(
      onPressed: onPressed,
      child: Text(text ?? 'Ok', style: TextStyle(color: secondaryColor)),
    );
  }
}
