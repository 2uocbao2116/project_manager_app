import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/project_screen/models/list_task_item.dart';
import 'package:projectmanager/src/views/project_screen/models/project_model.dart';
import 'package:projectmanager/src/views/project_screen/models/task_gdp.dart';

// ignore: must_be_immutable
class ProjectState extends Equatable {
  ProjectState({
    this.projectModel,
    this.listTaskItem,
    this.gdpTask,
    this.hasMore = false,
  });

  bool hasMore;
  ProjectModel? projectModel;
  ListTaskItem? listTaskItem;
  TaskGdp? gdpTask;

  @override
  List<Object?> get props => [
        projectModel,
        listTaskItem,
        gdpTask,
        hasMore,
      ];

  ProjectState copyWith({
    ProjectModel? projectModel,
    ListTaskItem? listTaskItem,
    TaskGdp? gdpTask,
    bool? hasMore,
  }) {
    return ProjectState(
      projectModel: projectModel ?? this.projectModel,
      listTaskItem: listTaskItem ?? this.listTaskItem,
      gdpTask: gdpTask ?? this.gdpTask,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// ignore: must_be_immutable
class FetchProjectSuccess extends ProjectState {
  FetchProjectSuccess({this.isSuccess});

  bool? isSuccess = true;

  @override
  List<Object?> get props => [isSuccess];
}
