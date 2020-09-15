class ApiError {
  ApiError({this.statusCode, this.error, this.message});

  ApiError.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'] as int;
    error = json['error'] as String;
    message = json['message'] as String;
  }

  int statusCode;
  String error;
  String message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
