import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/utils/gdp_data.dart';

// ignore: must_be_immutable
class GdpInitialModel extends Equatable {
  GdpInitialModel({this.gdpProject = const []});

  List<GDPData> gdpProject;

  GdpInitialModel copyWith({List<GDPData>? gdpProject}) {
    return GdpInitialModel(
      gdpProject: gdpProject ?? this.gdpProject,
    );
  }

  @override
  List<Object?> get props => [gdpProject];
}
