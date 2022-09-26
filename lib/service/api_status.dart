class Success {
  int code;
  Map<String, dynamic> response;
  Success({required this.code, required this.response});
}

class Failure {
  int code;
  Object errorResponse;
  Failure({required this.code, required this.errorResponse});
}
