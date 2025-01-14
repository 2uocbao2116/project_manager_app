import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';

// ignore: must_be_immutable
class ListTaskItem extends Equatable {
  ListTaskItem({this.listTasksItem = const []});

  List<TaskData> listTasksItem;

  ListTaskItem copyWith({List<TaskData>? listTasksItem}) {
    return ListTaskItem(
      listTasksItem: listTasksItem ?? this.listTasksItem,
    );
  }

  @override
  List<Object?> get props => [listTasksItem];
}
