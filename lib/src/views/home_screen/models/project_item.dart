import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProjectItem extends Equatable {
  ProjectItem(
      {this.projectName,
      this.activetasks,
      this.tasksComplete,
      this.date,
      this.id});

  String? projectName;

  String? activetasks;

  double? tasksComplete;

  String? date;

  int? id;

  ProjectItem copyWith({
    String? projectName,
    String? activetasks,
    double? tasksComplete,
    String? date,
    int? id,
  }) {
    return ProjectItem(
      projectName: projectName ?? this.projectName,
      activetasks: activetasks ?? this.activetasks,
      tasksComplete: tasksComplete ?? this.tasksComplete,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props =>
      [projectName, activetasks, tasksComplete, date, id];
}
