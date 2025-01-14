class TaskData {
  String? id;
  String? userId;
  String? username;
  String? name;
  String? description;
  String? type;
  String? contentSubmit;
  String? status;
  String? createdAt;
  String? dateEnd;
  List? links;

  TaskData({
    this.id,
    this.userId,
    this.username,
    this.name,
    this.description,
    this.type,
    this.contentSubmit,
    this.status,
    this.createdAt,
    this.dateEnd,
  });

  TaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    contentSubmit = json['content_submit'];
    status = json['status'];
    createdAt = json['created_at'];
    dateEnd = json['date_end'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (userId != null) {
      data['user_id'] = userId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (contentSubmit != null) {
      data['content_submit'] = contentSubmit;
    }
    if (type != null) {
      data['type'] = type;
    }
    if (status != null) {
      data['status'] = status;
    }
    if (dateEnd != null) {
      data['date_end'] = dateEnd;
    }
    return data;
  }
}
