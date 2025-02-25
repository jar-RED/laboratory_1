import 'package:flutter/material.dart';

class AddPhotoBottomSheet extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const AddPhotoBottomSheet({
    super.key,
    required this.isDarkMode,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: Icon(
            Icons.camera_alt,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          title: Text(
            'Take a Photo',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: onCameraTap,
        ),
        ListTile(
          leading: Icon(
            Icons.photo_library,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          title: Text(
            'Choose from Gallery',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: onGalleryTap,
        ),
      ],
    );
  }
}
