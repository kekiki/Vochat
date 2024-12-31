import 'dart:io';

import 'package:vochat/common/extensions/vochat_string_ext.dart';
import 'package:vochat/common/logger/vochat_log_util.dart';
import 'package:vochat/common/utils/vochat_download_util.dart';

import '../../common/utils/vochat_path_util.dart';
import 'vochat_download_queue.dart';

class VochatDownloadManager {
  String _downloadDirPath = '';
  final VochatDownloadQueue _queue = VochatDownloadQueue();

  /// 单例
  static VochatDownloadManager? _instance;
  static VochatDownloadManager get instance =>
      _instance ??= VochatDownloadManager._internal();
  VochatDownloadManager._internal() {
    _initDownloadDirectory();
  }

  Future<void> _initDownloadDirectory() async {
    String downloadDir = VochatPathUtil.downloadPath;
    final savedDir = Directory(downloadDir);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    _downloadDirPath = downloadDir;
  }

  Future<bool> isDownloaded(String urlString) async {
    if (urlString.isEmpty) return false;

    String downloadPath = downloadPathWithUrl(urlString);
    return await File(downloadPath).exists();
  }

  Future<bool> isDownloading(String urlString) async {
    if (urlString.isEmpty) return false;

    String downloadPath = downloadPathWithUrl(urlString);
    String tempPath = downloadPath.replaceAll('target', 'temp');
    return await File(tempPath).exists();
  }

  String downloadPathWithUrl(String urlString) {
    if (urlString.isEmpty) return '';

    String ext = urlString.split('.').last;
    return '$_downloadDirPath${urlString.md5}_target.$ext';
  }

  Future<void> preload(String urlString) async {
    if (urlString.isEmpty) return;
    if (await isDownloaded(urlString) || await isDownloading(urlString)) return;

    _queue.addTask(urlString, download);
  }

  Future<File?> download(
    String urlString, {
    Function(double value)? onProgress,
  }) async {
    if (urlString.isEmpty) return null;

    final downloadPath = downloadPathWithUrl(urlString);
    if (await isDownloaded(urlString)) {
      return File(downloadPath);
    }

    try {
      String tempPath = downloadPath.replaceAll('target', 'temp');
      final isSuccess = await VochatDownloadUtil.download(
        url: urlString,
        savePath: tempPath,
        onReceiveProgress: (count, total) {
          if (onProgress != null) {
            onProgress(count / total);
          }
        },
      );
      final tempFile = File(tempPath);
      if (isSuccess && tempFile.existsSync()) {
        VochatLogUtil.i('DownloadManager', 'download finished: $downloadPath');
        return tempFile.renameSync(downloadPath);
      } else {
        tempFile.delete().then((file) {}).catchError((err) {});
      }
    } catch (e) {
      VochatLogUtil.i('DownloadManager', 'download failed: ${e.toString()}');
    }
    return null;
  }
}
