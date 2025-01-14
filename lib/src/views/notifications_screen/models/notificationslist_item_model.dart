import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/utils/image_constant.dart';

// ignore: must_be_immutable
class NotificationslistItemModel extends Equatable {
  NotificationslistItemModel(
      {this.nowOne,
      this.youhavefriend,
      this.accept,
      this.dismiss,
      this.nowTwo,
      this.projectproject,
      this.youhaveanew,
      this.id}) {
    nowOne = nowOne ?? ImageConstant.imgZ5900111098027;
    youhavefriend = youhavefriend ?? "You have friend request from Quoc Bao";
    accept = accept ?? "Accept";
    dismiss = dismiss ?? "Dismiss";
    nowTwo = nowTwo ?? "now";
    projectproject = projectproject ?? "Project: Project Management";
    youhaveanew =
        youhaveanew ?? "You have a new task from the Project Management";
    id = id ?? "";
  }

  String? nowOne;
  String? youhavefriend;
  String? accept;
  String? dismiss;
  String? nowTwo;
  String? projectproject;
  String? youhaveanew;
  String? id;

  NotificationslistItemModel copyWith({
    String? nowOne,
    String? youhavefriend,
    String? accept,
    String? dismiss,
    String? nowTwo,
    String? projectproject,
    String? youhaveanew,
    String? id,
  }) {
    return NotificationslistItemModel(
      nowOne: nowOne ?? this.nowOne,
      youhavefriend: youhavefriend ?? this.youhavefriend,
      accept: accept ?? this.accept,
      dismiss: dismiss ?? this.dismiss,
      nowTwo: nowTwo ?? this.nowTwo,
      projectproject: projectproject ?? this.projectproject,
      youhaveanew: youhaveanew ?? this.youhaveanew,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        nowOne,
        youhavefriend,
        accept,
        dismiss,
        nowTwo,
        projectproject,
        youhaveanew,
        id
      ];
}
