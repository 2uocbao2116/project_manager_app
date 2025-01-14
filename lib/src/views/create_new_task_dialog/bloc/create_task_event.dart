import 'package:equatable/equatable.dart';

class CreateTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNewTaskInitialEvent extends CreateTaskEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ChangeDateEvent extends CreateTaskEvent {
  ChangeDateEvent({required this.date});
  DateTime date;

  @override
  List<Object?> get props => [date];
}

class CreateNewTaskEvent extends CreateTaskEvent {
  CreateNewTaskEvent();
  @override
  List<Object?> get props => [];
}
