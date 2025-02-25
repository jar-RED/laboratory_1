class PhotoEntry {
  final String path;
  String title;
  String description;
  final DateTime dateAdded;

  PhotoEntry({
    required this.path,
    this.title = '',
    this.description = '',
    required this.dateAdded,
  });
}
