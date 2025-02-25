import 'package:flutter/material.dart';

class AddPhotoButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDarkMode;

  const AddPhotoButton({
    super.key,
    required this.onPressed,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: isDarkMode ? Colors.white : Colors.black,
      foregroundColor: isDarkMode ? Colors.black : Colors.white,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}
