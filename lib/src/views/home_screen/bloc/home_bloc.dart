import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/api/websocket_service.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_event.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<FetchDataEvent>(_callGetProjects);
    // on<FetchGDPProjectEvent>(_callGetGDPProject);
  }

  final webSocket = WebSocketService();

  final _repository = Repository();

  var responseListData = ResponseListData<ProjectData>();

  var gdpProjectResp = ResponseData<ProjectData>();

  int currentPage = 0;

  Future<void> _callGetProjects(
    FetchDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasMore) {
      return;
    }
    String status = PrefUtils().getStatusFilterProject();
    String startDate = PrefUtils().getStartDateFilterProject();
    String endDate = PrefUtils().getEndDateFilterProject();
    var queryParams = <String, dynamic>{
      'status': status,
      'page': currentPage,
      'size': 10,
      'startDate': '$startDate 00:00',
      'endDate': '$endDate 00:00',
    };
    await _repository
        .getProjects(
      queryParams: queryParams,
    )
        .then(
      (value) async {
        if (value.pagination!.totalPages == 0) {
          return emit(
            state.copyWith(hasMore: true),
          );
        }
        emit(
          state.copyWith(
            homeInitialModelObj: state.homeInitialModelObj.copyWith(
              projectgridItemList:
                  List.of(state.homeInitialModelObj.projectgridItemList)
                    ..addAll(value.data!),
            ),
            hasMore: value.pagination!.currentPage! ==
                value.pagination!.totalPages! - 1,
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        _onGetProjectsError();
      },
    );
    currentPage++;
  }

  void _onGetProjectsError() {}
}
