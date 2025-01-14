import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/data/models/notifi/notification_data.dart';

// ignore: must_be_immutable
class NotificationsModel extends Equatable {
  NotificationsModel({this.notificationslistItemList = const []});

  List<NotificationData> notificationslistItemList;

  NotificationsModel copyWith(
      {List<NotificationData>? notificationlistItemList}) {
    return NotificationsModel(
      notificationslistItemList:
          notificationlistItemList ?? notificationslistItemList,
    );
  }

  @override
  List<Object?> get props => [notificationslistItemList];
}
