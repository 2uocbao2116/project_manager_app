import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/bloc/create_task_event.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/bloc/create_new_task_state.dart';

class CreateNewTaskBloc extends Bloc<CreateTaskEvent, CreateNewTaskState> {
  CreateNewTaskBloc(super.initialState) {
    on<CreateNewTaskInitialEvent>(_onInitialize);
    on<ChangeDateEvent>(_changeDate);
    on<CreateNewTaskEvent>(_callCreateNewTask);
  }

  final _repository = Repository();

  var taskResponse = ResponseData<TaskData>();

  _onInitialize(
    CreateNewTaskInitialEvent event,
    Emitter<CreateNewTaskState> emit,
  ) async {
    emit(state.copyWith(
      taskNameInputController: TextEditingController(),
      taskDescriptionInputController: TextEditingController(),
      taskContentSubmitInputController: TextEditingController(),
      dueDateInputController: TextEditingController(),
    ));
  }

  _changeDate(
    ChangeDateEvent event,
    Emitter<CreateNewTaskState> emit,
  ) {
    emit(state.copyWith(
        createNewTaskModelObj: state.createNewTaskModelObj?.copyWith(
      selectedDueDateInput: event.date,
    )));
  }

  Future<void> _callCreateNewTask(
    CreateTaskEvent event,
    Emitter<CreateNewTaskState> emit,
  ) async {
    var requestData = TaskData(
      userId: PrefUtils().getUser()!.id,
      name: state.taskNameInputController?.text,
      description: state.taskDescriptionInputController?.text,
      dateEnd: state.dueDateInputController?.text,
    );
    await _repository
        .createNewTask(requestData: requestData.toJson())
        .then((value) {
      taskResponse = value;
      _onCreateTaskSuccess(value, emit);
    }).onError((error, stackTrace) {
      _onCreateTaskError(error, emit);
    });
  }

  void _onCreateTaskSuccess(
    ResponseData resp,
    Emitter<CreateNewTaskState> emit,
  ) {
    if (resp.status == 200) {
      emit(
        CreateTaskSuccessState(isSuccess: true),
      );
    }
  }

  void _onCreateTaskError(
    Object? error,
    Emitter<CreateNewTaskState> emit,
  ) {
    String message = 'An unexpected error occurred.';
    if (error is DioException) {
      final errorResp = ResponseError.fromJson(error.response?.data);
      message = errorResp.detail!;
    }
    emit(
      CreateTaskErrorState(error: message),
    );
  }
}
