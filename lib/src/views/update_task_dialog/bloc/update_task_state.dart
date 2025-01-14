import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/views/update_task_dialog/models/update_task_model.dart';

// ignore: must_be_immutable
class UpdateTaskState extends Equatable {
  final TextEditingController? taskNameInputController;
  final TextEditingController? taskDescriptionInputController;
  final TextEditingController? dueDateInputController;

  UpdateTaskModel? updateTaskModelObj;

  UpdateTaskState(
      {this.taskNameInputController,
      this.taskDescriptionInputController,
      this.dueDateInputController,
      this.updateTaskModelObj});

  @override
  List<Object?> get props => [
        taskNameInputController,
        taskDescriptionInputController,
        dueDateInputController,
        updateTaskModelObj
      ];
  UpdateTaskState copyWith({
    TextEditingController? taskNameInputController,
    TextEditingController? taskDescriptionInputController,
    TextEditingController? dueDateInputController,
    UpdateTaskModel? updateTaskModelObj,
  }) {
    return UpdateTaskState(
      taskNameInputController:
          taskNameInputController ?? this.taskNameInputController,
      taskDescriptionInputController:
          taskDescriptionInputController ?? this.taskDescriptionInputController,
      dueDateInputController:
          dueDateInputController ?? this.dueDateInputController,
      updateTaskModelObj: updateTaskModelObj ?? this.updateTaskModelObj,
    );
  }
}

// ignore: must_be_immutable
class UpdateTaskSuccess extends UpdateTaskState {
  UpdateTaskSuccess({this.isSuccess, this.message});

  bool? isSuccess;
  String? message;

  @override
  List<Object?> get props => [isSuccess, message];
}
