import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/option_task_dialog/models/option_task_model.dart';

// ignore: must_be_immutable
class OptionTaskState extends Equatable {
  OptionTaskState({this.optionTaskModelObj});

  OptionTaskModel? optionTaskModelObj;

  @override
  List<Object?> get props => [optionTaskModelObj];
  OptionTaskState copyWith({OptionTaskModel? optionTaskModelObj}) {
    return OptionTaskState(
        optionTaskModelObj: optionTaskModelObj ?? this.optionTaskModelObj);
  }
}
