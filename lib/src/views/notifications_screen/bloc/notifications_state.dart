import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/notifications_screen/models/notifications_model.dart';

// ignore: must_be_immutable
class NotificationsState extends Equatable {
  NotificationsState({
    this.notificationsModelObj,
    this.hasMore = false,
  });

  NotificationsModel? notificationsModelObj;
  bool hasMore;

  @override
  List<Object?> get props => [notificationsModelObj, hasMore];

  NotificationsState copyWith(
      {NotificationsModel? notificationsModelObj, bool? hasMore}) {
    return NotificationsState(
      notificationsModelObj:
          notificationsModelObj ?? this.notificationsModelObj,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
