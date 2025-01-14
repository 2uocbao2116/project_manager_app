class ProjectModel {
  String? name;
  String? createdAt;
  String? description;
  String? dueDate;
  String? status;
  String? id;

  ProjectModel(
      {this.id,
      this.name,
      this.description,
      this.dueDate,
      this.createdAt,
      this.status});

  ProjectModel copyWith({
    String? name,
    String? description,
    String? dueDate,
    String? createdAt,
    String? status,
    String? id,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
