import 'dart:io';

import 'package:dio/dio.dart';

import 'colive_mime_type.dart';

class ColiveUploadUtil {
  ColiveUploadUtil._internal();

  static Future<bool> upload({
    required String url,
    required String filePath,
    Function(double)? progressCallback,
  }) async {
    String contentType = "application/octet-stream";
    final type = mime(filePath);
    if (type != null) {
      contentType = type;
    }

    final file = File(filePath);
    final fileLength = await file.length();
    final dio = Dio();
    final response = await dio.put(
      url,
      data: file.openRead(),
      options: Options(
        contentType: contentType,
        headers: {"Content-Length": fileLength},
      ),
      onSendProgress: (int sentBytes, int totalBytes) {
        double progressPercent = sentBytes / totalBytes * 100;
        progressCallback?.call(progressPercent);
      },
    );
    dio.close();
    return response.statusCode == 200;
  }
}
