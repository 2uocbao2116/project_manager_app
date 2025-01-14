import 'package:equatable/equatable.dart';

class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactInitialEvent extends ContactEvent {
  @override
  List<Object?> get props => [];
}

class FetchFriendsEvent extends ContactEvent {
  FetchFriendsEvent();
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class AssignTaskEvent extends ContactEvent {
  AssignTaskEvent(this.toUserId);
  String toUserId;

  @override
  List<Object?> get props => [toUserId];
}
