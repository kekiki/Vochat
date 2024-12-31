import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';

import '../../common/api/vochat_api_client.dart';

class VochatUploadManager {
  /// 单例
  static VochatUploadManager? _instance;
  static VochatUploadManager get instance =>
      _instance ??= VochatUploadManager._internal();
  VochatUploadManager._internal();

  final _apiClient = Get.find<VochatApiClient>();

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
