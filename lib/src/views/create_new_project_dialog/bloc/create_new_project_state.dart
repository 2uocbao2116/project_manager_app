import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateNewProjectState extends Equatable {
  CreateNewProjectState({
    this.projectNameInputController,
    this.dueDateInputController,
    this.projectDescriptionInputController,
  });

  TextEditingController? projectNameInputController;

  TextEditingController? dueDateInputController;

  TextEditingController? projectDescriptionInputController;

  @override
  List<Object?> get props => [
        projectNameInputController,
        dueDateInputController,
        projectDescriptionInputController,
      ];

  CreateNewProjectState copyWith({
    TextEditingController? projectNameInputController,
    TextEditingController? dueDateInputController,
    TextEditingController? projectDescriptionInputController,
  }) {
    return CreateNewProjectState(
      projectNameInputController:
          projectNameInputController ?? this.projectNameInputController,
      dueDateInputController:
          dueDateInputController ?? this.dueDateInputController,
      projectDescriptionInputController: projectDescriptionInputController ??
          this.projectDescriptionInputController,
    );
  }
}

// ignore: must_be_immutable
class CreateProjectSuccess extends CreateNewProjectState {
  final bool isSuccess;
  CreateProjectSuccess({required this.isSuccess});

  @override
  List<Object?> get props => [isSuccess];
}

// ignore: must_be_immutable
class CreateProjectFailure extends CreateNewProjectState {
  final String message;
  CreateProjectFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
