import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/gdp_data.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/project_screen/bloc/project_event.dart';
import 'package:projectmanager/src/views/project_screen/bloc/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc(super.initialState) {
    on<FetchTasksEvent>(_callGetTasks);
    on<FetchGDPTaskEvent>(_callGetGDPTask);
    on<FetchProjectEvent>(_callGetProject);
  }

  final _repository = Repository();

  var responseListData = ResponseListData<TaskData>();

  var gdpTaskResponse = ResponseData<TaskData>();

  var projectData = ResponseData<ProjectData>();

  int _currentPage = 0;

  Future<void> _callGetProject(
    FetchProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    String projectId = PrefUtils().getProject()!.id!;
    await _repository.getDetailProject(projectId).then((value) async {
      _onGetProjectSuccess(value, emit);
      add(FetchGDPTaskEvent());
    }).onError((error, stackTrace) {});
  }

  Future<void> _callGetTasks(
    FetchTasksEvent event,
    Emitter<ProjectState> emit,
  ) async {
    if (state.hasMore) {
      return;
    } else {
      String status = PrefUtils().getStatusFilterTask();
      var queryParams = <String, dynamic>{
        'status': status,
        'page': _currentPage,
        'size': 10,
      };
      await _repository.getTasks(queryParams: queryParams).then((value) async {
        if (value.pagination!.totalPages == 0) {
          return emit(state.copyWith(
            hasMore: true,
          ));
        }

        if (value.data != null) {
          emit(state.copyWith(
            listTaskItem: state.listTaskItem?.copyWith(
              listTasksItem: List.of(state.listTaskItem!.listTasksItem)
                ..addAll(value.data!),
            ),
            hasMore: value.pagination!.currentPage! ==
                value.pagination!.totalPages! - 1,
          ));
        }
      }).onError((error, stackTrace) {});
    }
    _currentPage++;
  }

  Future<void> _callGetGDPTask(
    FetchGDPTaskEvent event,
    Emitter<ProjectState> emit,
  ) async {
    await _repository.getGDPTask().then(
      (value) async {
        gdpTaskResponse = value;
        List<int> numbers = [];
        RegExp exp = RegExp(r'\d+');
        Iterable<Match> matches = exp.allMatches(gdpTaskResponse.message!);
        for (Match match in matches) {
          numbers.add(int.parse(match.group(0)!));
        }
        emit(
          state.copyWith(
            gdpTask: state.gdpTask?.copyWith(
              listGDPData: getChartData(numbers),
            ),
          ),
        );
      },
    );
  }

  void _onGetProjectSuccess(
    ResponseData<ProjectData> resp,
    Emitter<ProjectState> emit,
  ) {
    emit(
      state.copyWith(
        projectModel: state.projectModel?.copyWith(
          name: resp.data!.name,
          description: resp.data!.description,
          dueDate: resp.data!.dateEnd,
          id: resp.data!.id,
          createdAt: resp.data!.createdAt,
          status: resp.data!.status,
        ),
      ),
    );
  }

  List<GDPData> getChartData(List<int> value) {
    return [
      GDPData('Done', value[0]),
      GDPData('Pending', value[1]),
      GDPData('In Progress', value[2]),
    ];
  }
}
