enum ColiveMediaType { photo, video }

class ColiveMediaModel {
  final ColiveMediaType type;
  final String path;

  bool get isPhoto => type == ColiveMediaType.photo;

  bool get isVideo => type == ColiveMediaType.video;

  ColiveMediaModel({required this.type, required this.path});
}
