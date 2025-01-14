import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TaskItem extends Equatable {
  TaskItem({this.name, this.date, this.id, this.userId});

  String? name;

  String? date;

  String? id;

  String? userId;

  TaskItem copyWith({
    String? name,
    String? date,
    String? id,
    String? userId,
  }) {
    return TaskItem(
      name: name ?? this.name,
      date: date ?? this.date,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [name, date, id, userId];
}
