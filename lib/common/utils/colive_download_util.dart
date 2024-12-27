import 'package:dio/dio.dart';

import '../logger/colive_log_util.dart';

class ColiveDownloadUtil {
  ColiveDownloadUtil._internal();

  static Future<bool> download({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final dio = Dio();
    try {
      final response = await dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      ColiveLogUtil.e("DownloadUtil", "error => $e");
      return false;
    }
  }
}
