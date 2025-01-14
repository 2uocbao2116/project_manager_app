import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/update_project_dialog/models/update_project_model.dart';

// ignore: must_be_immutable
class UpdateProjectState extends Equatable {
  UpdateProjectState(
      {this.projectNameInputController,
      this.dueDateInputController,
      this.projectDescriptionInputController,
      this.updateProjectModelObj});

  TextEditingController? projectNameInputController;

  TextEditingController? dueDateInputController;

  TextEditingController? projectDescriptionInputController;

  UpdateProjectModel? updateProjectModelObj;

  @override
  List<Object?> get props => [
        projectNameInputController,
        dueDateInputController,
        projectDescriptionInputController,
        updateProjectModelObj,
      ];

  UpdateProjectState copyWith({
    TextEditingController? projectNameInputController,
    TextEditingController? dueDateInputController,
    TextEditingController? projectDescriptionInputController,
    UpdateProjectModel? updateProjectModelObj,
  }) {
    return UpdateProjectState(
      projectNameInputController:
          projectNameInputController ?? this.projectNameInputController,
      dueDateInputController:
          dueDateInputController ?? this.dueDateInputController,
      projectDescriptionInputController: projectDescriptionInputController ??
          this.projectDescriptionInputController,
      updateProjectModelObj:
          updateProjectModelObj ?? this.updateProjectModelObj,
    );
  }
}

// ignore: must_be_immutable
class UpdateProjectSuccess extends UpdateProjectState {
  UpdateProjectSuccess({this.isSuccess});

  bool? isSuccess;

  @override
  List<Object?> get props => [isSuccess];
}

// ignore: must_be_immutable
class GetProject extends UpdateProjectState {
  GetProject();

  final ProjectData? project = PrefUtils().getProject();

  @override
  List<Object?> get props => [];
}
