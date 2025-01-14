import 'package:equatable/equatable.dart';

class CreateNewProjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNewProjectInitialEvent extends CreateNewProjectEvent {
  @override
  List<Object?> get props => [];
}

class CreateProjectEvent extends CreateNewProjectEvent {
  CreateProjectEvent();
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ChangeDateEvent extends CreateNewProjectEvent {
  ChangeDateEvent({required this.date});
  DateTime date;

  @override
  List<Object?> get props => [date];
}
