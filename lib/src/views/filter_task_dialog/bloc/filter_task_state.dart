import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/views/filter_task_dialog/models/filter_task_model.dart';

// ignore: must_be_immutable
class FilterTaskState extends Equatable {
  FilterTaskState({this.dateInputController, this.filterTaskModelObj});

  TextEditingController? dateInputController;

  FilterTaskModel? filterTaskModelObj;

  @override
  List<Object?> get props => [dateInputController, filterTaskModelObj];
  FilterTaskState copyWith({
    TextEditingController? dateInputController,
    FilterTaskModel? filterTaskModelObj,
  }) {
    return FilterTaskState(
      dateInputController: dateInputController ?? this.dateInputController,
      filterTaskModelObj: filterTaskModelObj ?? this.filterTaskModelObj,
    );
  }
}
