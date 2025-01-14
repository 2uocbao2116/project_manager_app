class MessageSent {
  String? content;
  String? sender;
  String? receiver;
  String? userSender;

  MessageSent({
    this.content,
    this.sender,
    this.receiver,
    this.userSender,
  });

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['sender'] = sender.toString();
    data['receiver'] = receiver.toString();
    data['content'] = content!;

    return data;
  }

  MessageSent.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    sender = json['sender'];
    receiver = json['receiver'];
    userSender = json['userSender'];
  }
}
