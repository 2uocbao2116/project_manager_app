import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/views/filter_task_dialog/bloc/filter_task_event.dart';
import 'package:projectmanager/src/views/filter_task_dialog/bloc/filter_task_state.dart';

class FilterTaskBloc extends Bloc<FilterTaskEvent, FilterTaskState> {
  FilterTaskBloc(super.initialState) {
    on<FilterTaskInitialEvent>(_onInitialize);
    on<ChangeDateEvent>(_changeDate);
  }

  _onInitialize(
    FilterTaskInitialEvent event,
    Emitter<FilterTaskState> emit,
  ) async {
    emit(state.copyWith(
      dateInputController: TextEditingController(),
    ));
  }

  _changeDate(
    ChangeDateEvent event,
    Emitter<FilterTaskState> emit,
  ) {
    emit(state.copyWith(
        filterTaskModelObj: state.filterTaskModelObj?.copyWith(
      selectedDateInput: event.date,
    )));
  }
}
