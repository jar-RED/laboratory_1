import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'SnapStash',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Image.asset(
          'assets/images/logo.png',
          height: 30,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
