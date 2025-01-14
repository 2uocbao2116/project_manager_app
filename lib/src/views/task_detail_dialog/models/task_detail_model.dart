import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TaskDetailModel extends Equatable {
  String? id;

  String? name;

  String? username;

  String? description;

  String? dateEnd;

  String? status;

  TaskDetailModel({
    this.id,
    this.name,
    this.username,
    this.description,
    this.dateEnd,
    this.status,
  });

  TaskDetailModel copyWith(
      {String? id,
      String? name,
      String? username,
      String? description,
      String? dateEnd,
      String? status}) {
    return TaskDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      description: description ?? this.description,
      dateEnd: dateEnd ?? this.dateEnd,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, name, username, description, dateEnd, status];
}
