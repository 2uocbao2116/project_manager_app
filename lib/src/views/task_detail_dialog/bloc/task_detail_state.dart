import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';

// ignore: must_be_immutable
class TaskDetailState extends Equatable {
  TaskData? taskData;

  TextEditingController? inforReport;
  TaskDetailState({
    this.taskData,
    this.inforReport,
  });

  @override
  List<Object?> get props => [taskData, inforReport];
  TaskDetailState copyWith({
    TaskData? taskData,
    TextEditingController? inforReport,
    bool? isSubmitedEnabled,
  }) {
    return TaskDetailState(
      taskData: taskData ?? this.taskData,
      inforReport: inforReport ?? this.inforReport,
    );
  }
}

// ignore: must_be_immutable
class FetchDetailTaskFailure extends TaskDetailState {
  FetchDetailTaskFailure({this.message});

  String? message;

  @override
  List<Object?> get props => [message];
}
