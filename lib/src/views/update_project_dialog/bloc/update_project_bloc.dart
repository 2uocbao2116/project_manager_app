import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/views/update_project_dialog/bloc/update_project_event.dart';
import 'package:projectmanager/src/views/update_project_dialog/bloc/update_project_state.dart';

class UpdateProjectBloc extends Bloc<UpdateProjectEvent, UpdateProjectState> {
  UpdateProjectBloc(super.initialState) {
    on<UpdateProjectInitialEvent>(_onInitialize);
    on<ChangeDateEvent>(_changeDate);
    on<UpdateProject>(_callUpdateProject);
  }

  final _repository = Repository();

  var projectResponse = ResponseData<ProjectData>();

  _onInitialize(
    UpdateProjectInitialEvent event,
    Emitter<UpdateProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        projectNameInputController: TextEditingController(),
        dueDateInputController: TextEditingController(),
        projectDescriptionInputController: TextEditingController(),
      ),
    );
  }

  _changeDate(
    ChangeDateEvent event,
    Emitter<UpdateProjectState> emit,
  ) {}

  Future<void> _callUpdateProject(
    UpdateProject event,
    Emitter<UpdateProjectState> emit,
  ) async {
    var requestData = ProjectData(
      name: state.projectNameInputController!.text.isEmpty
          ? GetProject().project!.name
          : state.projectNameInputController?.text,
      description: state.projectDescriptionInputController!.text.isEmpty
          ? GetProject().project!.description
          : state.projectDescriptionInputController?.text,
      dateEnd: state.dueDateInputController!.text.isEmpty
          ? GetProject().project!.dateEnd
          : state.dueDateInputController?.text,
    );

    await _repository
        .updateProject(requestData: requestData.toJson())
        .then((value) {
      _onUpdateSuccess(value, emit);
    }).onError((error, stackTrace) {
      _onUpdateError(error, emit);
    });
  }

  void _onUpdateSuccess(
    ResponseData<ProjectData> resp,
    Emitter<UpdateProjectState> emit,
  ) {
    if (resp.status == 200) {
      emit(
        UpdateProjectSuccess(isSuccess: true),
      );
    }
  }

  void _onUpdateError(
    Object? error,
    Emitter<UpdateProjectState> emit,
  ) {}
}
