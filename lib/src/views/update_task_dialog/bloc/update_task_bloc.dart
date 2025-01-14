import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/update_task_dialog/bloc/update_task_event.dart';
import 'package:projectmanager/src/views/update_task_dialog/bloc/update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc(super.initialState) {
    on<ChangeDateEvent>(_changeDate);
    on<UpdateTask>(_onUpdateTask);
    on<FetchTaskDetail>(_onGetTaskDetail);
  }

  final _repository = Repository();

  TaskData taskData = TaskData();

  _changeDate(
    ChangeDateEvent event,
    Emitter<UpdateTaskState> emit,
  ) {
    emit(state.copyWith(
        updateTaskModelObj: state.updateTaskModelObj?.copyWith(
      selectedDueDateInput: event.date,
    )));
  }

  Future<void> _onGetTaskDetail(
    FetchTaskDetail event,
    Emitter<UpdateTaskState> emit,
  ) async {
    String taskId = PrefUtils().getCurrentTaskId();
    await _repository.getDetailTask(taskId).then(
      (value) async {
        if (value.status == 200) {
          taskData = value.data!;
          emit(
            state.copyWith(
              taskNameInputController:
                  TextEditingController(text: value.data!.name),
              dueDateInputController:
                  TextEditingController(text: value.data!.dateEnd),
              taskDescriptionInputController:
                  TextEditingController(text: value.data!.description),
            ),
          );
        }
      },
    );
  }

  Future<void> _onUpdateTask(
    UpdateTask event,
    Emitter<UpdateTaskState> emit,
  ) async {
    taskData.name = state.taskNameInputController!.text;
    taskData.description = state.taskDescriptionInputController!.text;
    taskData.dateEnd = state.dueDateInputController!.text;
    await _repository
        .updateTask(requestData: taskData.toJson())
        .then((value) async {
      if (value.status == 200) {
        emit(
          UpdateTaskSuccess(isSuccess: true, message: value.message),
        );
      }
    }).onError((error, stackTrace) {});
  }
}
