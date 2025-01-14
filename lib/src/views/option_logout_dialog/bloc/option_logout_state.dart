import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/option_logout_dialog/models/option_logout_model.dart';

// ignore: must_be_immutable
class OptionLogoutState extends Equatable {
  OptionLogoutState({this.optionLogoutModelObj});

  OptionLogoutModel? optionLogoutModelObj;

  @override
  List<Object?> get props => [optionLogoutModelObj];
  OptionLogoutState copyWith(OptionLogoutModel? optionLogoutModelObj) {
    return OptionLogoutState(
        optionLogoutModelObj:
            optionLogoutModelObj ?? this.optionLogoutModelObj);
  }
}
