import 'package:equatable/equatable.dart';

class UpdateTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ChangeDateEvent extends UpdateTaskEvent {
  ChangeDateEvent({required this.date});

  DateTime date;

  @override
  List<Object?> get props => [date];
}

class UpdateTask extends UpdateTaskEvent {
  UpdateTask();
  @override
  List<Object?> get props => [];
}

class FetchTaskDetail extends UpdateTaskEvent {
  FetchTaskDetail();
  @override
  List<Object?> get props => [];
}
