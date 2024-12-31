import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';

import '../utils/vochat_path_util.dart';

class VochatLogUtil {
  static late final Logger _fileLogger;
  static late final Logger _consoleLogger;

  static String get logFilePath => "${VochatPathUtil.logPath}log.txt";

  VochatLogUtil._internal();

  static prettyJson(var json, {required String tag}) {
    try {
      String prettyJsonStr = const JsonEncoder.withIndent('  ').convert(json);
      d(tag, prettyJsonStr);
    } catch (e) {
      d(tag, json.toString());
    }
  }

  static Future<void> init() async {
    final logFileName = "${VochatPathUtil.logPath}log.txt";
    final file = File(logFileName);
    await file.create(recursive: true);
    final lastModifiedDateTime = await file.lastModified();
    final nowDateTime = DateTime.now();
    final duration = nowDateTime.difference(lastModifiedDateTime);
    if (duration.inHours >= 72) {
      await file.writeAsString("", mode: FileMode.writeOnly, flush: true);
      await file.setLastModified(nowDateTime);
    }
    _fileLogger = Logger(
      filter: _FileLogFilter(),
      printer: _FileLogPrinter(),
      output: _FileLogOutput(file: file),
    );
    _consoleLogger = Logger(
      filter: DevelopmentFilter(),
      printer: PrettyPrinter(methodCount: 0),
      output: ConsoleOutput(),
    );
  }

  static void close() {
    _fileLogger.close();
    _consoleLogger.close();
  }

  static void upload() async {
    final file = File(logFilePath);
    final exists = await file.exists();
    if (!exists) return;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final tempFile =
        await file.copy("${VochatPathUtil.logPath}${timestamp}_temp_log.txt");
    // TODO: upload log file
    // await upload(tempFile)
    await tempFile.delete();
  }

  static void t(String tag, String message, [bool write = false]) {
    final dateTime = DateTime.now().toUtc().toString();
    final content = "[$dateTime]:[$tag]: $message";
    _consoleLogger.t(content);
    if (!write) return;
    _fileLogger.t(content);
  }

  static void d(String tag, String message, [bool write = false]) {
    final dateTime = DateTime.now().toUtc().toString();
    final content = "[$dateTime]:[$tag]: $message";
    _consoleLogger.d(content);
    if (!write) return;
    _fileLogger.d(content);
  }

  static void i(String tag, String message, [bool write = true]) {
    final dateTime = DateTime.now().toUtc().toString();
    final content = "[$dateTime]:[$tag]: $message";
    final isHttp = content.contains("http://") || content.contains("https://");
    if (!isHttp) {
      _consoleLogger.i(content);
    }
    if (!write) return;
    _fileLogger.i(content);
  }

  static void w(String tag, String message, [bool write = false]) {
    final dateTime = DateTime.now().toUtc().toString();
    final content = "[$dateTime]:[$tag]: $message";
    _consoleLogger.w(content);
    if (!write) return;
    _fileLogger.w(content);
  }

  static void e(String tag, String message, [bool write = false]) {
    final dateTime = DateTime.now().toUtc().toString();
    final content = "[$dateTime]:[$tag]: $message";
    if (!content.contains("http://") || !content.contains("https://")) {
      _consoleLogger.e(content);
    }
    if (!write) return;
    _fileLogger.e(content);
  }
}

class _FileLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    final message = event.message.toString();
    if (message.contains("heartbeat")) {
      return false;
    }
    return true;
  }
}

class _FileLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [event.message.toString()];
  }
}

class _FileLogOutput extends LogOutput {
  final File file;
  IOSink? _sink;

  _FileLogOutput({required this.file});

  @override
  Future<void> init() async {
    _sink = file.openWrite(
      mode: FileMode.writeOnlyAppend,
      encoding: utf8,
    );
  }

  @override
  void output(OutputEvent event) {
    _sink?.writeAll(event.lines, '\n');
    _sink?.writeln();
  }

  @override
  Future<void> destroy() async {
    await _sink?.flush();
    await _sink?.close();
  }
}
