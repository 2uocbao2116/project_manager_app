import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/utils/gdp_data.dart';

// ignore: must_be_immutable
class TaskGdp extends Equatable {
  TaskGdp({this.listGDPData = const []});

  List<GDPData> listGDPData;

  TaskGdp copyWith({List<GDPData>? listGDPData}) {
    return TaskGdp(
      listGDPData: listGDPData ?? this.listGDPData,
    );
  }

  @override
  List<Object?> get props => [listGDPData];
}
