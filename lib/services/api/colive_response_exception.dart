class ColiveResponseException implements Exception {
  int code;
  String msg;

  ColiveResponseException({required this.code, required this.msg});

  @override
  String toString() {
    return 'ColiveResponseException{code: $code, msg: $msg}';
  }
}

class NullResponse implements Exception {
  NullResponse();

  @override
  String toString() {
    return 'NullResponse';
  }
}
