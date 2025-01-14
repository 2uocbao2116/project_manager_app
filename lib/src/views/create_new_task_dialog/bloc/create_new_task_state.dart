import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/models/create_new_task_model.dart';

// ignore: must_be_immutable
class CreateNewTaskState extends Equatable {
  CreateNewTaskState(
      {this.taskNameInputController,
      this.taskDescriptionInputController,
      this.dueDateInputController,
      this.taskContentSubmitInputController,
      this.createNewTaskModelObj});

  TextEditingController? taskNameInputController;
  TextEditingController? taskDescriptionInputController;
  TextEditingController? dueDateInputController;
  TextEditingController? taskContentSubmitInputController;
  CreateNewTaskModel? createNewTaskModelObj;

  @override
  List<Object?> get props => [
        taskNameInputController,
        taskDescriptionInputController,
        dueDateInputController,
        taskContentSubmitInputController,
        createNewTaskModelObj
      ];
  CreateNewTaskState copyWith({
    TextEditingController? taskNameInputController,
    TextEditingController? taskDescriptionInputController,
    TextEditingController? dueDateInputController,
    TextEditingController? taskContentSubmitInputController,
    CreateNewTaskModel? createNewTaskModelObj,
  }) {
    return CreateNewTaskState(
      taskNameInputController:
          taskNameInputController ?? this.taskNameInputController,
      taskDescriptionInputController:
          taskDescriptionInputController ?? this.taskDescriptionInputController,
      dueDateInputController:
          dueDateInputController ?? this.dueDateInputController,
      taskContentSubmitInputController: taskContentSubmitInputController ??
          this.taskContentSubmitInputController,
      createNewTaskModelObj:
          createNewTaskModelObj ?? this.createNewTaskModelObj,
    );
  }
}

// ignore: must_be_immutable
class CreateTaskSuccessState extends CreateNewTaskState {
  final bool isSuccess;
  CreateTaskSuccessState({required this.isSuccess});

  @override
  List<Object?> get props => [isSuccess];
}

// ignore: must_be_immutable
class CreateTaskErrorState extends CreateNewTaskState {
  final String error;
  CreateTaskErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
