import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';

import '../api/colive_api_client.dart';

class ColiveUploadManager {
  /// 单例
  static ColiveUploadManager? _instance;
  static ColiveUploadManager get instance =>
      _instance ??= ColiveUploadManager._internal();
  ColiveUploadManager._internal();

  final _apiClient = Get.find<ColiveApiClient>();

  Future<List<String>> uploadFiles({required List<XFile> fileList}) async {
    FormData formData = FormData();
    for (var xfile in fileList) {
      final file =
          await MultipartFile.fromFile(xfile.path, filename: xfile.name);
      formData.files.add(MapEntry('file[]', file));
    }

    final result = await _apiClient.uploadImages(formData).response;
    if (result.isSuccess && result.data != null) {
      final List images = result.data['images'] ?? [];
      return images.map((e) => e.toString()).toList();
    }
    return [];
  }
}
