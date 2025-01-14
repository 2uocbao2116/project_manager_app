class ResponseError {
  int? status;
  String? title;
  String? detail;

  ResponseError({this.status, this.title, this.detail});

  ResponseError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title = json['title'];
    detail = json['detail'];
  }
}
