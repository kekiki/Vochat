import 'dart:async';

class ColiveDownloadQueue {
  List<_DownlodTaskInfo> _taskList = [];
  bool _isTaskRunning = false;
  bool _isCancelQueue = false;

  Future<void> addTask(String urlString, Function(String urlString) workTask) {
    _isCancelQueue = false;
    _DownlodTaskInfo taskInfo = _DownlodTaskInfo(urlString, workTask);

    /// 创建future
    Completer<_DownlodTaskInfo> taskCompleter = Completer<_DownlodTaskInfo>();

    /// 创建当前任务stream
    StreamController<_DownlodTaskInfo> streamController = StreamController();
    taskInfo.controller = streamController;

    /// 添加到任务队列
    _taskList.add(taskInfo);

    /// 当前任务的stream添加监听
    streamController.stream.listen((_DownlodTaskInfo completeTaskInfo) {
      if (completeTaskInfo.urlString == taskInfo.urlString) {
        taskCompleter.complete(completeTaskInfo);
        streamController.close();
      }
    });

    /// 触发任务
    _doTask();

    return taskCompleter.future;
  }

  void cancelTask() {
    _taskList = [];
    _isCancelQueue = true;
    _isTaskRunning = false;
  }

  _doTask() async {
    if (_isTaskRunning) return;
    if (_taskList.isEmpty) return;

    /// 取任务
    _DownlodTaskInfo taskInfo = _taskList[0];
    _isTaskRunning = true;

    /// 模拟执行任务
    await taskInfo.workTask.call(taskInfo.urlString);

    taskInfo.controller?.sink.add(taskInfo);

    if (_isCancelQueue) return;

    /// 出队列
    _taskList.removeAt(0);
    _isTaskRunning = false;

    /// 递归执行任务
    _doTask();
  }
}

class _DownlodTaskInfo {
  String urlString;
  Function(String taskGift) workTask;
  StreamController<_DownlodTaskInfo>? controller;

  _DownlodTaskInfo(this.urlString, this.workTask);
}
