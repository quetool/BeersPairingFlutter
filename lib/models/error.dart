class ApiError {
  ApiError({this.statusCode, this.error, this.message});

  ApiError.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    message = json['message'];
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
