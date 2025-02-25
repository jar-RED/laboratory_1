import 'package:flutter/material.dart';
import '../../models/photo_entry.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/photo_service.dart';
import 'widgets/photo_grid.dart';
import 'widgets/empty_state.dart';
import 'widgets/add_photo_bottom_sheet.dart';
import 'widgets/add_photo_button.dart';
import 'widgets/theme_toggle_button.dart';
import 'widgets/app_title.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PhotoEntry> _photos = [];
  final PhotoService _photoService = PhotoService();

  Future<void> _addPhoto(ImageSource source) async {
    final photo = await _photoService.addPhoto(source);
    if (photo != null) {
      setState(() {
        _photos.add(photo);
      });
    }
  }

  Future<void> _editPhotoDetails(int index) async {
    final titleController = TextEditingController(text: _photos[index].title);
    final descriptionController =
        TextEditingController(text: _photos[index].description);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Photo Details',
          style: TextStyle(fontSize: 20),
        ),
        titleTextStyle: TextStyle(
          color: widget.isDarkMode ? Colors.white : Colors.black,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter a title for your photo',
                labelStyle: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
                hintStyle: TextStyle(
                  color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description',
                labelStyle: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
                hintStyle: TextStyle(
                  color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              maxLines: 2,
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _photos[index].title = titleController.text;
                _photos[index].description = descriptionController.text;
              });
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deletePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  void _showAddPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddPhotoBottomSheet(
        isDarkMode: widget.isDarkMode,
        onCameraTap: () {
          Navigator.pop(context);
          _addPhoto(ImageSource.camera);
        },
        onGalleryTap: () {
          Navigator.pop(context);
          _addPhoto(ImageSource.gallery);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppTitle(),
        actions: [
          ThemeToggleButton(
            isDarkMode: widget.isDarkMode,
            onPressed: () => widget.toggleTheme(),
          ),
        ],
      ),
      body: _photos.isEmpty
          ? const EmptyState()
          : PhotoGrid(
              photos: _photos,
              onEdit: _editPhotoDetails,
              onDelete: _deletePhoto,
              isDarkMode: widget.isDarkMode,
            ),
      floatingActionButton: AddPhotoButton(
        onPressed: _showAddPhotoOptions,
        isDarkMode: widget.isDarkMode,
      ),
    );
  }
}
