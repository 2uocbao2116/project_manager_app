import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/app_navigation_screen/models/app_navigation_model.dart';

// ignore: must_be_immutable
class AppNavigationState extends Equatable {
  AppNavigationState({this.appNavigationModelObj});

  AppNavigationModel? appNavigationModelObj;

  @override
  List<Object?> get props => [appNavigationModelObj];

  AppNavigationState copyWith({AppNavigationModel? appNavigationModelObj}) {
    return AppNavigationState(
      appNavigationModelObj:
          appNavigationModelObj ?? this.appNavigationModelObj,
    );
  }
}
