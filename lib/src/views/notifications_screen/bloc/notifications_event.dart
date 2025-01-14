import 'package:equatable/equatable.dart';

class NotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationsInitialEvent extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class FetchNotificationEvent extends NotificationsEvent {}

// ignore: must_be_immutable
class ConfirmFriendEvent extends NotificationsEvent {
  String senderId;
  String notifiId;
  ConfirmFriendEvent(this.senderId, this.notifiId);

  @override
  List<Object?> get props => [senderId, notifiId];
}

// ignore: must_be_immutable
class DeleteNotificationEvent extends NotificationsEvent {
  String notifiId;
  DeleteNotificationEvent(this.notifiId);
  @override
  List<Object?> get props => [notifiId];
}
