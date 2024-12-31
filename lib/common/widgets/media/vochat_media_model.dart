enum VochatMediaType { photo, video }

class VochatMediaModel {
  final VochatMediaType type;
  final String path;

  bool get isPhoto => type == VochatMediaType.photo;

  bool get isVideo => type == VochatMediaType.video;

  VochatMediaModel({required this.type, required this.path});
}
