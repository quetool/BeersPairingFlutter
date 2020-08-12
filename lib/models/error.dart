class Error {
  int statusCode;
  String error;
  String message;

  Error({this.statusCode, this.error, this.message});

  Error.fromJson(Map<String, dynamic> json) {
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
