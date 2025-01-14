class ProjectData {
  String? id;
  String? userId;
  String? name;
  String? description;
  String? status;
  double? tasksComplete;
  String? createdAt;
  String? dateEnd;
  List? links;

  ProjectData(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.status,
      this.tasksComplete,
      this.createdAt,
      this.dateEnd,
      this.links});

  ProjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    tasksComplete = json['tasks_complete'];
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
    if (id != null) {
      data['id'] = id;
    }
    if (userId != null) {
      data['user_id'] = userId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (status != null) {
      data['status'] = status;
    }
    if (createdAt != null) {
      data['created_at'] = createdAt;
    }
    if (dateEnd != null) {
      data['date_end'] = dateEnd;
    }
    if (links != null) {
      data['links'] = links?.map((v) => v).toList();
    }
    return data;
  }
}
