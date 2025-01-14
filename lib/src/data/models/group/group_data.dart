class GroupData {
  String? id;
  String? name;
  String? lastMessage;
  String? date;
  String? userId;

  GroupData({this.id, this.name, this.userId});

  GroupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['userId'];
    lastMessage = json['lastMessage'];
    date = json['time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }
}
