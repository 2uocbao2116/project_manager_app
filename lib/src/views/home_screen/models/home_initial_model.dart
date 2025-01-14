import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';

// ignore: must_be_immutable
class HomeInitialModel extends Equatable {
  HomeInitialModel({this.projectgridItemList = const []});

  List<ProjectData> projectgridItemList;

  HomeInitialModel copyWith({List<ProjectData>? projectgridItemList}) {
    return HomeInitialModel(
      projectgridItemList: projectgridItemList ?? this.projectgridItemList,
    );
  }

  @override
  List<Object?> get props => [projectgridItemList];
}
