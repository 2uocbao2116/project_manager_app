class NotificationData {
  String? id;
  String? recipientId;
  String? message;
  bool? status;
  String? type;
  String? date;
  String? senderId;

  NotificationData({
    this.id,
    this.recipientId,
    this.message,
    this.status,
    this.type,
    this.date,
    this.senderId,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipientId = json['userId'];
    message = json['message'];
    status = json['status'];
    type = json['type'];
    date = json['createdAt'];
    senderId = json['senderId'];
  }
}
