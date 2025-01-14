import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/task_detail_dialog/bloc/task_detail_event.dart';
import 'package:projectmanager/src/views/task_detail_dialog/bloc/task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  TaskDetailBloc(super.initialState) {
    on<FetchDetailTask>(_onFetchDetailTask);
    on<ReportTask>(_onReportTask);
  }

  final _repository = Repository();

  Future<void> _onReportTask(
    ReportTask event,
    Emitter<TaskDetailState> emit,
  ) async {
    TaskData taskData = TaskData(
        contentSubmit: event.inforReport, userId: PrefUtils().getUser()!.id!);
    await _repository
        .updateReport(requestData: taskData.toJson())
        .then((onValue) async {
      if (onValue.status == 200) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
      } else {
        emit(FetchDetailTaskFailure(
          message: onValue.message,
        ));
      }
    }).onError((error, stackStace) {
      String errorMessage = 'An unexpected error occurred.';
      if (error is DioException) {
        final errorResp = ResponseError.fromJson(error.response?.data);
        errorMessage = errorResp.detail!;
      }
      emit(FetchDetailTaskFailure(
        message: errorMessage,
      ));
    });
  }

  Future<void> _onFetchDetailTask(
    FetchDetailTask event,
    Emitter<TaskDetailState> emit,
  ) async {
    String taskId = PrefUtils().getCurrentTaskId();
    await _repository.getDetailTask(taskId).then(
      (value) async {
        if (value.status == 200) {
          emit(
            state.copyWith(taskData: value.data),
          );
        }
      },
    ).onError((error, stackStace) {
      String errorMessage = 'An unexpected error occurred.';
      if (error is DioException) {
        final errorResp = ResponseError.fromJson(error.response?.data);
        errorMessage = errorResp.detail!;
      }
      emit(FetchDetailTaskFailure(
        message: errorMessage,
      ));
    });
  }
}
