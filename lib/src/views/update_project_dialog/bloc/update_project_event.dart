import 'package:equatable/equatable.dart';

class UpdateProjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateProjectInitialEvent extends UpdateProjectEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ChangeDateEvent extends UpdateProjectEvent {
  ChangeDateEvent({required this.date});

  DateTime date;

  @override
  List<Object?> get props => [date];
}

class FetchDetailProject extends UpdateProjectEvent {
  FetchDetailProject();
  @override
  List<Object?> get props => [];
}

class UpdateProject extends UpdateProjectEvent {
  UpdateProject();
  @override
  List<Object?> get props => [];
}
