import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/option_project_dialog/models/option_project_model.dart';

// ignore: must_be_immutable
class OptionProjectState extends Equatable {
  OptionProjectState({this.optionProjectModelObj});

  OptionProjectModel? optionProjectModelObj;

  @override
  List<Object?> get props => [optionProjectModelObj];
  OptionProjectState copyWith({OptionProjectModel? optionProjectModelObj}) {
    return OptionProjectState(
        optionProjectModelObj:
            optionProjectModelObj ?? this.optionProjectModelObj);
  }
}
