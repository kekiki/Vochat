class VochatResponseException implements Exception {
  int code;
  String msg;

  VochatResponseException({required this.code, required this.msg});

  @override
  String toString() {
    return 'VochatResponseException{code: $code, msg: $msg}';
  }
}

class NullResponse implements Exception {
  NullResponse();

  @override
  String toString() {
    return 'NullResponse';
  }
}
