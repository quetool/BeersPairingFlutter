class ApiError {
  int statusCode;
  String error;
  String message;

  ApiError({this.statusCode, this.error, this.message});

  ApiError.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}
