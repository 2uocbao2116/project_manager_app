import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/home_screen/models/gdp_initial_model.dart';
import 'package:projectmanager/src/views/home_screen/models/home_initial_model.dart';

// ignore: must_be_immutable
class HomeState extends Equatable {
  bool hasMore;
  HomeInitialModel homeInitialModelObj;
  GdpInitialModel gdpInitialModel;

  HomeState({
    this.hasMore = false,
    required this.homeInitialModelObj,
    required this.gdpInitialModel,
  });

  HomeState copyWith({
    bool? hasMore,
    HomeInitialModel? homeInitialModelObj,
    GdpInitialModel? gdpInitialModel,
  }) {
    return HomeState(
      hasMore: hasMore ?? this.hasMore,
      homeInitialModelObj: homeInitialModelObj ?? this.homeInitialModelObj,
      gdpInitialModel: gdpInitialModel ?? this.gdpInitialModel,
    );
  }

  @override
  List<Object?> get props => [homeInitialModelObj, gdpInitialModel, hasMore];
}
