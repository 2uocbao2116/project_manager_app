class ResponseData<T> {
  int? status;
  T? data;
  String? message;

  ResponseData({this.status, this.data, this.message});

  ResponseData.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    status = json['status'];
    if (json['data'] != null) {
      data = fromJsonT(json['data']);
    }
    message = json['message'];
  }

  ResponseData.fromJson2(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }
}
