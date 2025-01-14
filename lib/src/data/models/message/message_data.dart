class MessageData {
  String? id;
  String? message;
  String? createdAt;
  String? userId;
  String? groupId;
  String? userSender;

  MessageData({
    this.id,
    this.message,
    this.createdAt,
    this.userId,
    this.groupId,
    this.userSender,
  });

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['createdAt'];
    userId = json['userId'];
    groupId = json['groupId'];
    userSender = json['userSender'];
  }
}
