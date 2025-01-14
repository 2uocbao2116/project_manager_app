import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/views/filter_project_dialog/bloc/filter_project_event.dart';
import 'package:projectmanager/src/views/filter_project_dialog/bloc/filter_project_state.dart';

class FilterProjectBloc extends Bloc<FilterProjectEvent, FilterProjectState> {
  FilterProjectBloc(super.initialState) {
    on<FilterProjectInitialEvent>(_onInitialize);
  }

  var listProjectsResp = ResponseListData<ProjectData>();

  _onInitialize(
    FilterProjectInitialEvent event,
    Emitter<FilterProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        statusInputController: TextEditingController(),
        startDateInputController: TextEditingController(),
        endDateInputController: TextEditingController(),
      ),
    );
  }
}
