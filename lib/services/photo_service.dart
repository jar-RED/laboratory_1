import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/photo_entry.dart';

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  Future<PhotoEntry?> addPhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await File(image.path).copy('${appDir.path}/$fileName');

    return PhotoEntry(
      path: savedImage.path,
      dateAdded: DateTime.now(),
    );
  }
}
