import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/views/create_new_project_dialog/bloc/create_new_project_event.dart';
import 'package:projectmanager/src/views/create_new_project_dialog/bloc/create_new_project_state.dart';

class CreateNewProjectBloc
    extends Bloc<CreateNewProjectEvent, CreateNewProjectState> {
  CreateNewProjectBloc(super.initialState) {
    on<CreateNewProjectInitialEvent>(_onInitialize);
    on<CreateProjectEvent>(_callCreateProject);
  }

  final _repository = Repository();

  var responseData = ResponseData<ProjectData>();

  _onInitialize(
    CreateNewProjectInitialEvent event,
    Emitter<CreateNewProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        projectNameInputController: TextEditingController(),
        dueDateInputController: TextEditingController(),
        projectDescriptionInputController: TextEditingController(),
      ),
    );
  }

  FutureOr<void> _callCreateProject(
    CreateProjectEvent event,
    Emitter<CreateNewProjectState> emit,
  ) async {
    var projectDataReq = ProjectData(
      name: state.projectNameInputController?.text ?? '',
      description: state.projectDescriptionInputController?.text ?? '',
      dateEnd: state.dueDateInputController?.text ?? '',
    );
    await _repository
        .createNewProject(
      requestData: projectDataReq.toJson(),
    )
        .then((value) async {
      responseData = value;
      _onCreateProjectSuccess(responseData, emit);
    }).onError((error, stackTrace) {
      _onCreateProjectError(error, emit);
    });
  }

  void _onCreateProjectSuccess(
    ResponseData resp,
    Emitter<CreateNewProjectState> emit,
  ) {
    if (resp.status == 200) {
      emit(
        CreateProjectSuccess(isSuccess: true),
      );
    }
  }

  void _onCreateProjectError(
    Object? error,
    Emitter<CreateNewProjectState> emit,
  ) {
    String message = 'An unexpected error occurred.';
    if (error is DioException) {
      final errorResp = ResponseError.fromJson(error.response?.data);
      message = errorResp.detail!;
    }
    emit(
      CreateProjectFailure(message: message),
    );
  }
}
