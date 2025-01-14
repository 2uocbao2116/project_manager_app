import 'package:equatable/equatable.dart';

class TaskDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDetailTask extends TaskDetailEvent {
  FetchDetailTask();

  @override
  List<Object?> get props => [];
}

class ReportTask extends TaskDetailEvent {
  final String inforReport;

  ReportTask({required this.inforReport});

  @override
  List<Object?> get props => [inforReport];
}
